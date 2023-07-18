import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/env/env.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_messages.dart';
import 'package:the_specials_app/shared/state_management/audio/stm_audio.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/type_messages.dart';

class Messages extends StatefulWidget {
  const Messages({super.key, required this.messageData});
  final MessageData messageData;
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final loggedUserDataController = Get.put<LoggedUserDataController>(LoggedUserDataController());
  final String orientationEnd = 'end';
  final String orientationStart = 'start';
  bool _audioPlay = false;
  final player = AudioPlayer();

  String validateContentNotNull(String? content) {
    if(content != null) {
      return content;
    }
    return '';
  }
  validateImageAndReturn() {
    var messagePicture = widget.messageData.path;
    if(messagePicture!.isNotEmpty) {
      return NetworkImage('${Env.baseURLImage}${messagePicture.replaceAll(r"\", r"")}');
    } else {
      return const AssetImage(
        'assets/images/profile-picture.png',
      );
    }
  }
  boxMessageWithUserIdLogged(Widget content, double borderRadius, double paddingContentMessage, orientation) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: orientation == orientationEnd ? const EdgeInsets.only(right: 10): const EdgeInsets.only(left: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: orientation == orientationEnd ? MainAxisAlignment.end : MainAxisAlignment.start ,
          crossAxisAlignment: orientation == orientationEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 20, maxWidth: MediaQuery.of(context).size.width / 2),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      alignment:  orientation == orientationEnd ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
                      decoration: BoxDecoration(
                        color: orientation == orientationEnd ? DefaultColors.purpleBrand: DefaultColors.blueBrand,
                        borderRadius: BorderRadius.circular(borderRadius),

                      ),
                      child: Padding(
                        padding: EdgeInsets.all(paddingContentMessage),
                        child: content,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const  SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
  returnImageMessage(orientation) {
    return boxMessageWithUserIdLogged(
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: validateImageAndReturn(),
                fit: BoxFit.cover,
                alignment: const Alignment(-0.3, 0),
              ),
            ),
          ),
        ),
        10,
        5,
        orientation
    );
  }
  returnTextMessage(orientation) {
    return boxMessageWithUserIdLogged(
        Text(
          validateContentNotNull(widget.messageData.content),
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14
          ),
        ),
        20,
        10,
        orientation
    );
  }
  void _toggleAudio() {
    setState(() {
      _audioPlay = !_audioPlay;
    });
  }
  returnAudioMessage(orientation) {
    return boxMessageWithUserIdLogged(
        Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        !_audioPlay ? Icons.play_arrow: Icons.stop_circle_sharp,
                        color: Colors.white,
                      ),
                      onPressed: () async{
                        print('audio play: $_audioPlay');
                        _toggleAudio();
                        player.stop();
                        if(_audioPlay) {
                          await player.play(UrlSource('${Env.baseURLImage}${widget.messageData.path.replaceAll(r"\", r"")}'));
                        }else {
                          await player.stop();
                        }

                      },
                      iconSize: 35,

                    ),
                  ],
                ),

              ],
            )
          ],
        ),
        20,
        10,
        orientation
    );
  }
  Widget validateTypeMessage() {
    print('messages 24 messageType: ${widget.messageData.type}');
    switch (widget.messageData.type) {
      case TypesMessages.typeText:
        if(widget.messageData.content != null) {
          if(widget.messageData.userId != loggedUserDataController.savedUserData?.data?.id) {
            return returnTextMessage(orientationStart);
          } else {
            return returnTextMessage(orientationEnd);
          }
        } else {
          return const SizedBox(
            width: 0,
            height: 0,
          );
        }
      case TypesMessages.typeImage:
        print('message 119: ${loggedUserDataController.savedUserData?.data?.id}');
        if(widget.messageData.path != null) {
          if(widget.messageData.userId != loggedUserDataController.savedUserData?.data?.id) {
            return returnImageMessage(orientationStart);
          } else {
            return returnImageMessage(orientationEnd);
          }
        } else {
          return const SizedBox(
            width: 0,
            height: 0,
          );
        }
      case TypesMessages.typeAudio:
        if(widget.messageData.path != null) {
          if(widget.messageData.userId != loggedUserDataController.savedUserData?.data?.id) {
            return returnAudioMessage(orientationStart);
          } else {
            return returnAudioMessage(orientationEnd);
          }
        } else {
          return const SizedBox(
            width: 0,
            height: 0,
          );
        }

      default:
        return const SizedBox(
          width: 0,
          height: 0,
        );
    }
  }

  Widget validateMessageUserOrMatch() {
    if(widget.messageData.matchId == loggedUserDataController.savedUserData?.data?.id) {
      return Container(
        child: validateTypeMessage(),
      );
    } else {
      return Container(
        child: validateTypeMessage(),
      );
    }
  }
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return validateMessageUserOrMatch();
  }
}
