import 'package:flutter/material.dart';
import 'package:the_specials_app/shared/components/btns/btns_translate.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class ButtonsLoginCreate extends StatelessWidget {
  const ButtonsLoginCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonPrimary(onPressed: () {
          Navigator.pushNamed(context, RoutesApp.preRegister);
        }, texto: btnCreateAccount.i18n),
        const SizedBox(height: 15),
        ButtonSecondary(onPressed: () {
          Navigator.pushNamed(context, RoutesApp.login);
        }, texto: btnLogin.i18n)
      ],
    );
  }
}
