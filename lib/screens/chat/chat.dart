// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:the_specials_app/env/env.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/services/factory/send_message.dart';
import 'package:the_specials_app/shared/services/functions/functions.dart';
import 'package:the_specials_app/shared/services/functions/functions_images.dart';
import 'package:the_specials_app/shared/state_management/other_profile_data/other_profile_data.dart';
import 'package:the_specials_app/shared/state_management/stm_messages/stm_messages.dart';
import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class Chat extends StatefulWidget {
  const Chat({super.key, required this.matchData});
  final UserDataProfile? matchData;
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final stmMessagesController = Get.put<STMMessagesController>(STMMessagesController());
  final otherProfileUserDataController = Get.put<OtherProfileDataController>(OtherProfileDataController());

  final form = FormGroup({
    'message': FormControl<String>(
      validators: [Validators.required],
    ),
  });
  UserDataProfile? match;
  final _service = ConsumeApisService();
  final ScrollController _scrollController = ScrollController();
  getArguments() {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    match = UserDataProfile.fromJson(arguments['matchData'].toJson());
  }
  validateImageAndReturn() {
    getArguments();
    var profilePicture = match?.data?.profilePicture;
    if(profilePicture!.isNotEmpty) {
      return NetworkImage('${Env.baseURLImage}${profilePicture[0].path?.replaceAll(r"\", r"")}');
    } else {
      return const AssetImage(
        'assets/images/profile-picture.png',
      );
    }
  }
  loading() {
    return     Container(
        color: Colors.transparent,
        child:  Center(child: CircularProgressIndicator(color: DefaultColors.purpleBrand, backgroundColor: Colors.transparent,)));
  }
  @override
  Widget build(BuildContext context) {
    scrollingMessages() {
      _scrollController.addListener(() {
        print('chat 48: offset${_scrollController.offset}');
        print('chat 49: intialoffset${_scrollController.initialScrollOffset}');
      });
    }
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFD0E0FD),
              Color(0xFFE8D9FD)
            ],
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,

        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            // here the desired height
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              // ...
            ),
        ),
        body: Column(
          children: [
            Container(
              decoration:  BoxDecoration(
                color: const Color(0xFFD0E0FD),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0.0, 0.75),// changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      color: DefaultColors.blueBrand,
                      iconSize: 35,
                      onPressed: () {
                        Navigator.popAndPushNamed(context, RoutesApp.listPersonsChats);
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {

                        int userId = match?.data?.id as int;
                        await _service.getOtherProfile(userId);
                        await otherProfileUserDataController.getProfileUserData();
                        Navigator.pushNamed(context, RoutesApp.othersProfiles);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(
                            color: Colors.transparent
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: 60,
                              height: 60,
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
                          Text(
                            '${match?.data?.name as String}, ${Functions().transformAge(match?.data?.birthdate)}',
                            style: const TextStyle(
                                color: DefaultColors.blueBrand,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                reverse: true,
                  child: GetBuilder<STMMessagesController>(
                    builder: (_) => (!_.listUpdated.value)?
                     loading() :  Column(
                      children: stmMessagesController.createBaloonChat(_.savedMessages),
                    ),

                  )


              ),
            ),
            ReactiveFormBuilder(
                form: () => form,
                builder: (context, form, child) {
                  return SizedBox(

                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 25, 5, 25),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: DefaultColors.blueBrand),
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: ReactiveTextField(
                                  formControlName: 'message',
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      onPressed: () async {
                                        print('message saved 209 chat');
                                        print(stmMessagesController.savedMessages);
                                        await _service.postMessage(FactorySendMessage(
                                            matchId: stmMessagesController.matchIdChat,
                                            content: form.control('message').value,
                                            type: 'text'
                                        ), queryParameters: {'match_id': stmMessagesController.matchIdChat});
                                        // Timer(const Duration(milliseconds: 500), () {
                                          form.control('message').value = '';
                                        // });
                                      },
                                      icon: const Icon(
                                        Icons.send_outlined,
                                        color: DefaultColors.purpleBrand,
                                      ),
                                    ),

                                  ),

                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              FunctionsImages().openPickImageToSendChat(context);
                              // FunctionsImages().setImageToSendMessage(, stmMessagesController.savedMessages?.data?[0].matchId as int)

                            },
                            icon: const Icon(
                              Icons.attach_file,
                              color: DefaultColors.purpleBrand,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
