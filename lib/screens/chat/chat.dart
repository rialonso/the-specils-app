import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:the_specials_app/shared/state_management/stm_messages/stm_messages.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    final stmMessagesController = Get.put<STMMessagesController>(STMMessagesController());
    final form = FormGroup({
      'message': FormControl<String>(
        validators: [Validators.required],
      ),
    });

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
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            // here the desired height
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              // ...
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    color: DefaultColors.blueBrand,
                    iconSize: 35,
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesApp.listPersonsChats);
                    },
                  ),
                ],
              ),
              SingleChildScrollView(
                  child: GetBuilder<STMMessagesController>(
                    builder: (_) => (!stmMessagesController.listUpdated.value)?
                    Text('loading') :  Column(
                      children: stmMessagesController.createBaloonChat(stmMessagesController.savedMessages),
                    ),

                  )


              ),
            ],
          ),
        ),
          bottomNavigationBar: ReactiveFormBuilder(
            form: () => form,
            builder: (context, form, child) {
              return SizedBox(

                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: DefaultColors.blueBrand),
                            borderRadius: BorderRadius.circular(25)
                          ),
                          child: ReactiveTextField(
                            formControlName: 'message',
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          )
      ),
    );
  }
}
