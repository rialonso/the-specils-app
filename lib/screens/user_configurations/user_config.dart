import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/screens/user_configurations/translate_user_config.dart';
import 'package:the_specials_app/shared/components/menu_logged/menu_logged.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/state_management/state_manament.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class UserConfig extends StatefulWidget {
  const UserConfig({Key? key}) : super(key: key);
  @override
  State<UserConfig> createState() => _UserConfigState();
}

class _UserConfigState extends State<UserConfig> {
  final stateManagementAll = Get.put<StateManagementAllController>(StateManagementAllController());
  final _service = ConsumeApisService();
  final loggedUserData = Get.put<LoggedUserDataController>(LoggedUserDataController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFD0E0FD), Color(0xFFE8D9FD)])
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            // here the desired height
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              // ...
            )),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
             Container(
               width: MediaQuery.of(context).size.width,
               margin: const EdgeInsets.only(bottom: 20),
               child: Text(
                  settingsTitle.i18n,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                    fontSize: 30,
                    color: DefaultColors.greyMedium,
                    fontWeight: FontWeight.w800,
                  ),
                ),
             ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonSettings(onPressed: () async{
                    UserData userData = await loggedUserData.getUserData();
                    await _service.getProfile(userData.data?.id);
                    Navigator.pushNamed(context, RoutesApp.profile);
                  }, text: btnSettingsUpdateProfile.i18n, icon: 'account_circle',),
                  const SizedBox(
                    height: 20, //<-- SEE HERE
                  ),
                  ButtonSettings(onPressed: (){}, text: btnPreferences.i18n, icon: 'interests',),
                  const SizedBox(
                    height: 20, //<-- SEE HERE
                  ),
                  ButtonSettings(onPressed: (){
                    Navigator.pushNamed(context, RoutesApp.changePassword);
                  }, text: btnChangePassword.i18n, icon: 'password',),
                  const SizedBox(
                    height: 20, //<-- SEE HERE
                  ),
                  ButtonSettings(onPressed: (){
                  StateManagementAllController().clearAll();
                  Navigator.pushNamed(context, RoutesApp.login);
                  }, text: btnLogout.i18n, icon: 'logout',),

                ],
              ),
            ],
          ),

        ),
        bottomNavigationBar: const MenuLogged(routeUserConfig: true,),
      ),
    );
  }
}
