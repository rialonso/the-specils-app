import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';
import 'package:the_specials_app/screens/first_page/translation_first_page.dart';
import 'package:the_specials_app/shared/components/btns/btns_login_create.dart';
import 'package:the_specials_app/shared/components/logo.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';

import '../../env/env.dart';
import '../../shared/services/apis/consume_apis.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final loggedUserDataController = Get.put<LoggedUserDataController>(LoggedUserDataController());
  final ConsumeApisService _service = ConsumeApisService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initApp();
    getNewMatches();
  }
  getNewMatches() async {
    await loggedUserDataController.getUserData();
    var pusherOptions = PusherOptions(
      cluster: Env.webSocket.cluster,
      host: Env.webSocket.url as String,
      encrypted: true,
      port:  Env.webSocket.port as int,
    );
    LaravelFlutterPusher pusher = LaravelFlutterPusher(Env.webSocket.key as String, pusherOptions, enableLogging: true);
    pusher.connect();

    pusher
        .subscribe('${Env.webSocket.channels?.matches}${loggedUserDataController.savedUserData.data?.id}')
        .bind(Env.webSocket.events?.matches as String, (event) async{
      if (kDebugMode) {
        print('newMATCH');
        print(event['payload']);
      }
      _service.getMatches();
      Navigator.pushNamed(context, RoutesApp.listPersonsChats);

    });
    // Navigator.pushNamed(context, RoutesApp.chat,arguments: {'matchData':otherProfile});
  }

  initApp() async{
    await loggedUserDataController.getUserData();
    print(loggedUserDataController!.savedUserData!.status);
    if(loggedUserDataController!.savedUserData!.status == null) {
      return;
    }

    Navigator.pushNamed(context, RoutesApp.suggestionCards);
  }
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
                children: const [
                  Logo(),
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
              const ButtonsLoginCreate(),
            ],
          ),
        ),

      ),
    );
  }
}
