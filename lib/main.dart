import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:the_specials_app/screens/first_page/first_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', "US"),
        Locale('pt', "BR"),
      ],
      home: I18n(
          child: FirstPage()
      ),
    );
  }
}
