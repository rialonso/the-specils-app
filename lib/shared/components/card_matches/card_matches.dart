// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';
import 'package:the_specials_app/env/env.dart';
import 'package:the_specials_app/screens/chat/chat.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_messages.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_user_matches.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/state_management/stm_messages/stm_messages.dart';
import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';
import 'package:the_specials_app/shared/state_management/user_matches/stm_user_matches.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class CardMatches extends StatefulWidget {
  const CardMatches({super.key, required this.match});
  final ListUserMatchesData match;
  @override
  State<CardMatches> createState() => _CardMatchesState();
}

class _CardMatchesState extends State<CardMatches> {
  final stmUserMatchesController = Get.put<STMUserMatchesController>(STMUserMatchesController());
  final stmMessagesController = Get.put<STMMessagesController>(STMMessagesController());

  final ConsumeApisService _service = ConsumeApisService();

  validateImageAndReturn() {
    var profilePicture = widget.match.targetUser?.profilePicture;
    if(profilePicture!.isNotEmpty) {
      return NetworkImage('${Env.baseURLImage}${profilePicture[0].path?.replaceAll(r"\", r"")}');
    } else {
      return const AssetImage(
        'assets/images/profile-picture.png',
      );
    }
  }
  validateTypeLastMessage() {
    if(widget.match.latestMessage?.type == 'text') {
      if(widget.match.latestMessage?.content != null) {
        return Text(
          widget.match.latestMessage?.content as String,
          style: const TextStyle(
              fontSize: 20,
              color: DefaultColors.greyMedium
          ),

        );
      } else {
        return const Text('');
      }


    }
  }
  getChat(matchId) async {
    await _service.getMessagesMatchId(
        queryParameters: {'match_id': matchId}
    );
    UserDataProfile otherProfile  = await _service.getProfile(widget.match.targetUser?.id);
    var pusherOptions = PusherOptions(
      // if local on android use 10.0.2.2\
      cluster: Env.webSocket.cluster,
      host: Env.webSocket.url as String,
      encrypted: true,
      port:  Env.webSocket.port as int,
    );
    LaravelFlutterPusher pusher = LaravelFlutterPusher(Env.webSocket.key as String, pusherOptions, enableLogging: true);
    pusher.connect();

    await stmMessagesController.getMessages();
    pusher
        .subscribe('${Env.webSocket.channels?.chat}$matchId')
        .bind(Env.webSocket.events?.chat as String, (event) {
      if (kDebugMode) {
        print(event['payload']);
        
      }
      setState(() {
        stmMessagesController.addNewMessagesPusherSubscription(MessageData.fromJson(event['payload']));
        stmMessagesController.update();
      });

    });
    Navigator.pushNamed(context, RoutesApp.chat,arguments: {'matchData':otherProfile});
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: GetBuilder<STMUserMatchesController>(
        builder: (_) {
          if (widget.match.targetUser?.accountType == 'special') {
            // print(profileUserDataController.userDataUpdated.value);
            return ElevatedButton(
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.transparent,
               side: const BorderSide(
                 color: Colors.transparent
               ),
               elevation: 0,
             ),
              onPressed: () {
                getChat(widget.match.matchId);
              },
              child: Column(

                children: [
                  Padding(

                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: validateImageAndReturn(),
                                fit: BoxFit.cover,
                                alignment: const Alignment(-0.3, 0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  widget.match.targetUser?.name as String,
                                style: const TextStyle(
                                  color: DefaultColors.blueBrand,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              validateTypeLastMessage(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                    color: DefaultColors.greySoft,
                  ),
                ],
              ),
            );
          } else {
            return const Text('');
          }
        },
      ),
    );
  }
}
