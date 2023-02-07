import 'package:flutter/material.dart';
import 'package:the_specials_app/screens/login/translate_login.dart';
import 'package:the_specials_app/shared/components/btns/btns_login_create.dart';
import 'package:the_specials_app/shared/components/header_logged_out/header_logged_out.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _passwordVisible = true;

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              texto: login.i18n,
            ),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextFormField(
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
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
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
                  ButtonPrimary(onPressed: () {}, texto: btnSignin.i18n),
                  ButtonSecondary(onPressed: () {}, texto: createAccount.i18n),
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
                        color: DefaultColors.blueBrand,
                        fontSize: 15
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
