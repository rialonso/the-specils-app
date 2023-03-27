import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:the_specials_app/screens/change_password/change_password.dart';
import 'package:the_specials_app/screens/first_page/first_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:the_specials_app/screens/login/login.dart';
import 'package:the_specials_app/screens/profile/profile.dart';
import 'package:the_specials_app/screens/suggestion_matchs/suggestion_matchs.dart';
import 'package:the_specials_app/screens/user_configurations/user_config.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The specials',
      theme: defaultColorsTheme,
      routes: {
        RoutesApp.login: (context) => const Login(),
        RoutesApp.suggestionCards: (context) =>  SuggestionMatchs(),
        RoutesApp.userConfig: (context) => const UserConfig(),
        RoutesApp.changePassword: (context) => const ChangePassword(),
        RoutesApp.profile: (context) => const Profile(),

      },

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', "US"),
        Locale('pt', "BR"),
      ],
      home: I18n(
          child: FirstPage()
      ),
    );
  }
}
class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({required this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}
