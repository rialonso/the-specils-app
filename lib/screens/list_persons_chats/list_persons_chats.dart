import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/env/env.dart';
import 'package:the_specials_app/shared/components/menu_logged/menu_logged.dart';
import 'package:the_specials_app/shared/services/web_sockets/ws_connection_chat.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';

class ListPersonsChats extends StatefulWidget {
  const ListPersonsChats({Key? key}) : super(key: key);

  @override
  State<ListPersonsChats> createState() => _ListPersonsChatsState();
}

class _ListPersonsChatsState extends State<ListPersonsChats> {

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
        body: ButtonPrimary(onPressed: () async{
        }, texto: 'cht'),
        bottomNavigationBar:  const MenuLogged(personsChats: true),

    ),
    );
  }
}
