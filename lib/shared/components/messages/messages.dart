import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_messages.dart';
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
  String validateContentNotNull(String? content) {
    if(content != null) {
      return content;
    }
    return '';
  }
  Widget validateTypeMessage() {
    switch (widget.messageData.type) {
      case TypesMessages.typeText:
        if(widget.messageData.content != null) {
          if(widget.messageData.userId != loggedUserDataController.savedUserData?.data?.id) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 20, maxWidth: MediaQuery.of(context).size.width / 2),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Container(
                              alignment: AlignmentDirectional.centerStart,
                              decoration: BoxDecoration(
                                color: DefaultColors.blueBrand,
                                borderRadius: BorderRadius.circular(20),

                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(

                                  validateContentNotNull(widget.messageData.content),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14
                                  ),
                                ),
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
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(minWidth: 20, maxWidth: MediaQuery.of(context).size.width / 2),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Container(
                              alignment: AlignmentDirectional.centerEnd,
                              decoration: BoxDecoration(
                                color: DefaultColors.purpleBrand,
                                borderRadius: BorderRadius.circular(20),

                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(

                                  validateContentNotNull(widget.messageData.content),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14
                                  ),
                                ),
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
  Widget build(BuildContext context) {

    return validateMessageUserOrMatch();
  }
}
