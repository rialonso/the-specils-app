import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/screens/change_password/translate_change_password.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/services/factory/change_password_factory.dart';
import 'package:the_specials_app/shared/services/functions/functions.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final userDataController = Get.put<LoggedUserDataController>(LoggedUserDataController());

  final _service = ConsumeApisService();

  bool _passwordVisible = true;
  bool _newPasswordVisible = true;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();


  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
  void _toggleNewPassword() {
    setState(() {
      _newPasswordVisible = !_newPasswordVisible;
    });
  }
  postSavePassword() async {
    var dataChangePassword = ChangePasswordFactory(
      old_password: oldPasswordController.text,
      password: newPasswordController.text,
    );
    UserData userData = await userDataController.getUserData();
    var response = await _service.postChangePassword(userData.data?.id, dataChangePassword);
    if(response.toJson()['status']) {
      Functions().openSnackBar(context, DefaultColors.greenSoft, snackBarSuccessSaved.i18n, buttonSnackBar.i18n);
      Navigator.pushNamed(context, RoutesApp.userConfig);
    } else {
      Functions().openSnackBar(context, DefaultColors.redDefault, snackBarErrorSaved.i18n, buttonSnackBar.i18n);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFD0E0FD), Color(0xFFE8D9FD)])
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
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                      Navigator.pushNamed(context, RoutesApp.userConfig);
                    },
                  ),

                  Text(
                    titleChangePassword.i18n,
                    style: const TextStyle(
                      fontSize: 25,
                      color: DefaultColors.greyMedium,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    children: [
                      TextFormField(
                        controller: oldPasswordController,
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                          hintText: oldPassword.i18n,
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              _toggle();
                            },
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'sa';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: newPasswordController,
                        obscureText: _newPasswordVisible,
                        decoration: InputDecoration(
                          hintText: newPassword.i18n,
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _newPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              _toggleNewPassword();
                            },
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'sa';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ButtonPrimary(onPressed: (){
                    if (oldPasswordController.text == '' || newPasswordController.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: DefaultColors.redDefault,
                          content: const Text('Os campos devem ser preenchidos'),
                          action: SnackBarAction(
                            textColor: Colors.white,
                            label: 'Entendi',
                            onPressed: () {
                              // Code to execute.
                            },
                          ),
                        ),
                      );
                    }
                    postSavePassword();

                  }, texto: savePassword.i18n)
                ],
              )

            ],
          ),
        )
      ),
    );
  }
}
