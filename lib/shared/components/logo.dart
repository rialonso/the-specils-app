import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_specials_app/shared/styles/colors.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        SvgPicture.asset(
          'assets/images/logo.svg',
          width: 35,
          height: 35,
        ),
        const SizedBox(width: 10),
        const Text(
          'The Specials',
          style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w700,
              color: DefaultColors.blueBrand
          ),
        ),
      ],
    );
  }
}
