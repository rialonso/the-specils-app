import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_messages.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/values/type_messages.dart';

class Messages extends StatefulWidget {
  const Messages({super.key, required this.messageData});
  final MessageData messageData;
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    final loggedUserDataController = Get.put<LoggedUserDataController>(LoggedUserDataController());
    String validateContentNotNull(String? content) {
      if(content != null) {
        return content;
      }
      return '';
    }
    validateTypeMessage() {
      switch (widget.messageData.type) {
        case TypesMessages.typeText:
        return Text(
            validateContentNotNull(widget.messageData.content)
            );
          break;
      }
    }

    validateMessageUserOrMatch() {
      if(widget.messageData?.matchId == loggedUserDataController.savedUserData?.data?.id) {
        return Container(
          child: validateTypeMessage(),
        );
      } else {
        return Container(
          child: validateTypeMessage(),
        );
      }
    }
    return validateMessageUserOrMatch();
  }
}
