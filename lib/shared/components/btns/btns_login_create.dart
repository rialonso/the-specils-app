import 'package:flutter/material.dart';
import 'package:the_specials_app/shared/components/btns/btns_translate.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';

import '../../../screens/login/login.dart';

class ButtonsLoginCreate extends StatelessWidget {
  const ButtonsLoginCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonPrimary(onPressed: () {

        }, texto: btnCreateAccount.i18n),
        ButtonSecondary(onPressed: () {
          Navigator.pushNamed(context, '/login');
        }, texto: btnLogin.i18n)
      ],
    );
  }
}
