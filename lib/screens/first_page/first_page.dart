import 'package:flutter/material.dart';
import 'package:the_specials_app/screens/first_page/translation_first_page.dart';
import 'package:the_specials_app/shared/components/btns/btns_login_create.dart';
import 'package:the_specials_app/shared/components/logo.dart';
import 'package:the_specials_app/shared/styles/colors.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFD0E0FD), Color(0xFFE8D9FD)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0.0), // here the desired height
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              // ...
            )),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Logo(),
                ],
              ),
              RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  text: meetPeople.i18n,
                  style: const TextStyle(
                      color: DefaultColors.greyMedium,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                        text: special.i18n,
                        style: const TextStyle(color: DefaultColors.purpleBrand)),
                    TextSpan(text: as.i18n),
                    TextSpan(
                        text: you.i18n,
                        style: const TextStyle(color: DefaultColors.blueBrand))
                  ],
                ),
              ),
              ButtonsLoginCreate(),
            ],
          ),
        ),

      ),
    );
  }
}
