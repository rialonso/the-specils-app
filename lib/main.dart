
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:the_specials_app/screens/camera_preview/camera_preview.dart';
import 'package:the_specials_app/screens/change_password/change_password.dart';
import 'package:the_specials_app/screens/chat/chat.dart';
import 'package:the_specials_app/screens/edit_about_me/edit_about_me.dart';
import 'package:the_specials_app/screens/edit_pictures/edit_pictures.dart';
import 'package:the_specials_app/screens/filter_preferences/filter_preferences.dart';
import 'package:the_specials_app/screens/first_page/first_page.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:the_specials_app/screens/liked_me/liked_me.dart';
import 'package:the_specials_app/screens/list_persons_chats/list_persons_chats.dart';
import 'package:the_specials_app/screens/login/login.dart';
import 'package:the_specials_app/screens/others_profile/others_profile.dart';
import 'package:the_specials_app/screens/pre-register/pre-register.dart';
import 'package:the_specials_app/screens/profile/profile.dart';
import 'package:the_specials_app/screens/suggestion_matchs/suggestion_matchs.dart';
import 'package:the_specials_app/screens/user_configurations/user_config.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/state_management/state_manament.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final loggedUserData = Get.put<LoggedUserDataController>(LoggedUserDataController());

  final stateManagementAll = Get.put<StateManagementAllController>(StateManagementAllController());

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  verifyLoggedUserData() async {
    UserData userData = await loggedUserData.getUserData();
    // if (userData?.status == null) {
    //   return '';
    // }
    if(userData.status == true) {
      stateManagementAll.clearAll();
      Navigator.pushNamed(Get.key.currentContext as BuildContext, RoutesApp.login);
    }
  }

  @override
  void didUpdateWidget(MyApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    verifyLoggedUserData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'The specials',
      theme: defaultColorsTheme,
      routes: {
        RoutesApp.login: (context) => const Login(),
        RoutesApp.suggestionCards: (context) =>  SuggestionMatchs(),
        RoutesApp.userConfig: (context) => const UserConfig(),
        RoutesApp.changePassword: (context) => const ChangePassword(),
        RoutesApp.profile: (context) => const Profile(),
        RoutesApp.editAboutMe: (context) => const EditAboutMe(),
        RoutesApp.likedMe: (context) => const LikedMe(),
        RoutesApp.othersProfiles: (context) => const OthersProfile(),
        RoutesApp.listPersonsChats: (context) => const ListPersonsChats(),
        RoutesApp.filterPreferences: (context) => const FilterPreferences(),
        RoutesApp.editPictures: (context) => const EditPictures(),
        RoutesApp.preRegister: (context) => const PreRegister(),
        RoutesApp.chat: (context) => const Chat(matchData: null,),
        RoutesApp.takePicture: (context) => const CameraPreviewScreen(),

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
          child: const FirstPage()
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
