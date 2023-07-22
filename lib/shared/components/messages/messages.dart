// ignore_for_file: avoid_single_cascade_in_expression_statements

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

class _MessagesState extends State<Messages> with TickerProviderStateMixin{
  final loggedUserDataController = Get.put<LoggedUserDataController>(LoggedUserDataController());
  final stmAudioController = Get.put<STMAudioController>(STMAudioController());

  final String orientationEnd = 'end';
  final String orientationStart = 'start';
  final player = AudioPlayer();
  late AnimationController controller;
  var currentPositionAudio;
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
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5),
    )..addListener(() {
      if (mounted) {
        setState(() {
          if (stmAudioController.savedAudio?.idAudioPlay !=
              widget.messageData.id) controller.stop();
        });
      }
    });
  }
  returnAudioMessage(orientation) {
    controller ??= AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 5),
      )..addListener(() {
      if (this.mounted) {
        setState(() {
          if (stmAudioController.savedAudio?.idAudioPlay != widget.messageData.id) controller.stop();

        });
      }
      });



    return boxMessageWithUserIdLogged(
       GetBuilder<STMAudioController>(builder:
       (_) {
         if(_.listUpdated.value) {
           return Row(
             children: [
               IconButton(
                 icon: Icon(
                   stmAudioController.audioPlay && stmAudioController.savedAudio?.idAudioPlay == widget.messageData.id? Icons.stop_circle_sharp: Icons.play_arrow,
                   color: Colors.white,
                 ),
                 onPressed: () async{
                   audioControllerPlayAndPause();

                 },
                 iconSize: 35,

               ),
               SizedBox(
                 width: 150,
                 child: LinearProgressIndicator(
                   color: Colors.white,
                   valueColor: orientation == orientationEnd ? const AlwaysStoppedAnimation<Color>(DefaultColors.blueBrand): const AlwaysStoppedAnimation<Color>(DefaultColors.purpleBrand),
                   value: controller.value,
                   semanticsLabel: 'Linear progress indicator',
                 ),
               ),
             ],
           );
         }
         return Text('');
       }
       ),
        20,
        10,
        orientation
    );
  }
  audioControllerPlayAndPause() async {
    stmAudioController.toggleAudio();
    await stmAudioController.stopAudio();
    controller.reset();
    if(!stmAudioController.audioPlay && stmAudioController.savedAudio?.idAudioPlay == widget.messageData.id) {
      await stmAudioController.player.getCurrentPosition().then((value) => currentPositionAudio = value);
      return;
    }
    // print('audio play true');
    await stmAudioController.saveAudioPlay(InterfaceAudioPlay(idAudioPlay: 1));
    if(!stmAudioController.audioPlay && stmAudioController.savedAudio?.idAudioPlay == 1) {
      stmAudioController.toggleAudio();
    }
    await stmAudioController.saveAudioPlay(InterfaceAudioPlay(idAudioPlay: widget.messageData.id));
    // print('messages 148: ${stmAudioController.audioPlay} e ${stmAudioController.savedAudio?.idAudioPlay} com ${widget.messageData.id}');
    if(stmAudioController.audioPlay && stmAudioController.savedAudio?.idAudioPlay == widget.messageData.id) {
      controller.repeat(period: Duration(milliseconds: widget.messageData.audioDuration));
      await stmAudioController.playAudio(widget.messageData.path);
      stmAudioController.player.onPlayerComplete.listen((_) {
        if (mounted) controller.reset();
        currentPositionAudio = const Duration(seconds: 0);
        stmAudioController.saveAudioPlay(InterfaceAudioPlay(idAudioPlay: 1));
      });
    }
  }
  Widget validateTypeMessage() {
    // print('messages 176 messageType: ${widget.messageData.type}');
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
        // print('message 192: ${loggedUserDataController.savedUserData?.data?.id}');
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
    if(controller == null) controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return validateMessageUserOrMatch();
  }
}
