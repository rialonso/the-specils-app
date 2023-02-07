import 'package:flutter/material.dart';
import 'package:the_specials_app/screens/login/translate_login.dart';
import 'package:the_specials_app/shared/styles/colors.dart';

class HeaderLoggedOut extends StatelessWidget {
  final String texto;
  const HeaderLoggedOut({Key? key, required this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: <Widget>[
        Ink(
          width: 40,
          height: 40,
          decoration: const ShapeDecoration(
            color: DefaultColors.greySoft,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ),
        const SizedBox(width: 10),
        Text(texto,
          style: const TextStyle(
            color: DefaultColors.blueBrand,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),)
      ],
    );
  }
}
