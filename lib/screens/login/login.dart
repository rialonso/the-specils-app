// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/screens/login/translate_login.dart';
import 'package:the_specials_app/screens/suggestion_matchs/suggestion_matchs.dart';
import 'package:the_specials_app/shared/blocs/suggestion_cards_bloc.dart';
import 'package:the_specials_app/shared/components/header_logged_out/header_logged_out.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/services/factory/login_factory.dart';
import 'package:the_specials_app/shared/services/functions/functions.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisible = true;
  final _service = ConsumeApisService();
  final loggedUserDataController = Get.put<LoggedUserDataController>(LoggedUserDataController());

  final SuggestionCardsBloc _suggestionBloc = SuggestionCardsBloc();

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titleLoginDevotee.i18n),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(messageLoginDevotee.i18n),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _signin(dynamic data) async {
    dynamic responseLogin = await _service.postLoginApi(LoginFactory(
        email: emailController.text, password: passwordController.text));
    if(responseLogin.status as bool) {
      if(loggedUserDataController.savedUserData.data?.accountType == 'special') {
        await _suggestionBloc.getSuggestionCards();
        await _service.getMatches();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SuggestionMatchs()
            )
        );
      } else {
        _showMyDialog();
      }

    } else {
      Functions().openSnackBar(context, DefaultColors.redDefault, snackBarErrorSavedLogin.i18n, buttonSnackBarLogin.i18n);
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderLoggedOut(
                  texto: login.i18n,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: email.i18n,
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
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
                              // Update the state i.e. toggle the state of passwordVisible variable
                              _toggle();
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),

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
                        _signin(_.data);
                      }, texto: btnSignin.i18n),
                      const SizedBox(height: 15),

                      ButtonSecondary(
                          onPressed: () {
                            Navigator.pushNamed(context, RoutesApp.preRegister);
                            // print(_bloc.saida);
                          },
                          texto: createAccount.i18n),
                      const SizedBox(height: 40),
                      const Divider(color: Colors.black),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Text(
                          rememberPassword.i18n,
                          style: const TextStyle(
                              color: DefaultColors.blueBrand, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
