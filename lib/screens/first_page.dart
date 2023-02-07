import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Logo(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: const Text(
                      'login',
                      style: TextStyle(
                          color: DefaultColors.blueBrand, fontSize: 20),
                    ),
                  ),
                ],
              ),
              RichText(
                text: const TextSpan(
                  text: 'conheça aqui alguém tão',
                  style: TextStyle(
                      color: DefaultColors.greyMedium,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                        text: ' especial',
                        style: TextStyle(color: DefaultColors.purpleBrand)),
                    TextSpan(text: ' quanto'),
                    TextSpan(
                        text: ' você',
                        style: TextStyle(color: DefaultColors.blueBrand))
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
