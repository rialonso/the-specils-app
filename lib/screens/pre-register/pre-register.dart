// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:the_specials_app/screens/edit_pictures/edit_pictures.dart';
import 'package:the_specials_app/screens/pre-register/pre-register.translate.dart';
import 'package:the_specials_app/shared/components/header_logged_out/header_logged_out.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/services/factory/login_factory.dart';
import 'package:the_specials_app/shared/services/functions/functions.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';
import 'package:the_specials_app/shared/services/factory/pre_register_factory.dart';

class PreRegister extends StatefulWidget {
  const PreRegister({super.key});

  @override
  State<PreRegister> createState() => _PreRegisterState();
}

class _PreRegisterState extends State<PreRegister> {
  bool _passwordVisible = true;
  final _service = ConsumeApisService();

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
  registerUser() async {
    dynamic responseLogin = await _service.postRegister(PreRegisterFactory(
        email: emailController.text, password: passwordController.text));
    if(responseLogin.toJson()['status']) {
      dynamic responseLogin = await _service.postLoginApi(LoginFactory(
          email: emailController.text, password: passwordController.text));
      // Navigator.pushNamed(context, RoutesApp.editPictures);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditPictures(showReturnRoute: false, buttonText: 'Continuar',),
          ));
    }else if(responseLogin?.toJson()?['message'] == 'Email em uso') {
      Functions().openSnackBar(context, DefaultColors.redDefault, snackBarEmailUsed.i18n, buttonSnackBarEmailInUse.i18n);
    }
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder <LoggedUserDataController>(
      init: LoggedUserDataController(),
      builder: (_) => Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0.0), // here the desired height
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              // ...
            )),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              HeaderLoggedOut(
                texto: titlePreRegister.i18n,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: email.i18n,
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return errorEmail.i18n;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _passwordVisible,
                      decoration: InputDecoration(
                        hintText: password.i18n,
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            _toggle();
                          },
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return errorPassword.i18n;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ButtonPrimary(onPressed: () {
                      registerUser();
                    },
                        texto: btnContinue.i18n),
                    const SizedBox(height: 15),

                    // ButtonSecondary(
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //       // print(_bloc.saida);
                    //     },
                    //     texto: btnReturn.i18n),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
