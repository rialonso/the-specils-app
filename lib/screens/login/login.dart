// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_specials_app/screens/edit_pictures/edit_pictures.dart';
import 'package:the_specials_app/screens/login/translate_login.dart';
import 'package:the_specials_app/screens/suggestion_matchs/suggestion_matchs.dart';
import 'package:the_specials_app/shared/blocs/suggestion_cards_bloc.dart';
import 'package:the_specials_app/shared/components/header_logged_out/header_logged_out.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/services/factory/login_factory.dart';
import 'package:the_specials_app/shared/services/factory/sign_in_google.dart';
import 'package:the_specials_app/shared/services/functions/auth_service.dart';
import 'package:the_specials_app/shared/services/functions/functions.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initApp();
  }
  initApp() async{
    await loggedUserDataController.getUserData();
    if(loggedUserDataController!.savedUserData!.status == null) {
      return;
    }
    Navigator.pushNamed(context, RoutesApp.suggestionCards);
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
    print(data);
    dynamic responseLogin = await _service.postLoginApi(LoginFactory(
        email: emailController.text, password: passwordController.text));
    afterSignIn(responseLogin);
  }
  afterSignIn (responseLogin) async {
    final loggedUserData = loggedUserDataController.savedUserData.data;
    if(responseLogin.status as bool) {
      if(loggedUserData?.accountType != null ) {
        if(loggedUserData?.accountType == 'special') {
          if(loggedUserData?.targetAccountType != "special") {
            await _service.postUpdateProfile(loggedUserDataController.savedUserData?.data?.id, {
              "target_account_type": "special"
            });
          }
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
        await _service.postUpdateProfile(loggedUserDataController.savedUserData?.data?.id, {
          "account_type": "special",
          "target_account_type": "special"
        });
        if(loggedUserData?.profilePicture == null || loggedUserData?.profilePicture?.length == 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  EditPictures(showReturnRoute: false, buttonText: btnContinueLogin.i18n,),
              ));
        }
        if(loggedUserData?.birthdate == null
            || loggedUserData?.name == null
            || loggedUserData?.gender == null
            || loggedUserData?.lat == null
            || loggedUserData?.lng == null
            || loggedUserData?.occupation == null
            || loggedUserData?.sexualOrientation == null) {
          Navigator.pushNamed(context, RoutesApp.editAboutMe);
        }
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
                      SignInButton(
                        Buttons.Google,
                        text: signInWithGoogle.i18n,
                        onPressed: () async {
                            final GoogleSignInAccount? gUser = await GoogleSignIn(clientId: "670097540184-l69jst81har5d985sj5j4l1800ukkm6s.apps.googleusercontent.com").signIn();
                            final GoogleSignInAuthentication gAuth = await gUser!.authentication;
                            final responseLogin = await ConsumeApisService().postLoginGoogleApi(GoogleSignInFactory(email: gUser.email, token: gAuth!.idToken as String));
                            afterSignIn(responseLogin);
                        },
                      )
                      // Button(onPressed: () async {
                      //   final GoogleSignInAccount? gUser = await GoogleSignIn(clientId: "670097540184-l69jst81har5d985sj5j4l1800ukkm6s.apps.googleusercontent.com").signIn();
                      //   final GoogleSignInAuthentication gAuth = await gUser!.authentication;
                      //   final responseLogin = await ConsumeApisService().postLoginGoogleApi(GoogleSignInFactory(email: gUser.email, token: gAuth!.idToken as String));
                      //   afterSignIn(responseLogin);
                      //   // _signin(_.data);
                      // }, texto: 'google', icon: ,)
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
