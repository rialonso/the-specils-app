import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';
// import 'package:pusher_client/pusher_client.dart';
import 'package:the_specials_app/env/env.dart';
import 'package:the_specials_app/shared/components/menu_logged/menu_logged.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_user_matches.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/state_management/user_matches/stm_user_matches.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';

class ListPersonsChats extends StatefulWidget {
  const ListPersonsChats({Key? key}) : super(key: key);

  @override
  State<ListPersonsChats> createState() => _ListPersonsChatsState();
}

class _ListPersonsChatsState extends State<ListPersonsChats> {
  bool fd = false;
  final _service = ConsumeApisService();
  final stmUserMatchesController = Get.put<STMUserMatchesController>(STMUserMatchesController());
  InterfaceUserMatches? userMatches;

  waitMatchesLoad() {
    var status = stmUserMatchesController?.savedUserMatches?.status;
    print('list_ppersons 42');
    print(stmUserMatchesController?.savedUserMatches?.status);
    if(status == false || status == null) {
      _service.getMatches();
      getSavedUserMatches();
    } else {
      getSavedUserMatches();
    }
  }
  getSavedUserMatches() async {
    await stmUserMatchesController.getUserMatches();
    userMatches = stmUserMatchesController.savedUserMatches;
    stmUserMatchesController.listUpdated(true);
    print('list_person 52');
    print(userMatches?.toJson());
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => waitMatchesLoad());
  }
  @override
  void didUpdateWidget(ListPersonsChats oldWidget) {
    super.didUpdateWidget(oldWidget);
    waitMatchesLoad();
    // waitGetUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFD0E0FD),
                Color(0xFFE8D9FD)
              ],
          )
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
        body: SingleChildScrollView(
          child: GetBuilder<STMUserMatchesController>(
            builder: (_) => (!stmUserMatchesController.listUpdated.value)?
            Text('loading') :  Column(
              children: stmUserMatchesController.createCardsMatches(userMatches),
            ),

          )


        ),
        bottomNavigationBar:  const MenuLogged(personsChats: true),

    ),
    );
  }
}
