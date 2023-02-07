import 'package:flutter/material.dart';
import 'package:the_specials_app/screens/first_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The specials',
      theme: ThemeData(
        fontFamily: 'Dosis',
        primarySwatch: Colors.blue,
      ),
      home: const FirstPage(),
    );
  }
}
