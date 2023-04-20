import 'package:flutter/material.dart';
import 'package:pusher_client/pusher_client.dart';
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
  bool fd = false;
  getChat() {
    var pusher = PusherClient(
      '1hfEn3KQ0G',
      PusherOptions(
        // if local on android use 10.0.2.2\
        cluster: Env.webSocketCluster,
        host: Env.webSocketURL,
        encrypted: true,
        wssPort: Env.webSocketPort,
        wsPort:  Env.webSocketPort,

      ),
      enableLogging: false,
    );
    var channel = pusher.subscribe('${Env.webSocketChannelChat}1234');
    pusher.onConnectionStateChange((state) {
      print("previousState: ${state?.previousState}, currentState: ${state?.currentState}");
    });
    print(fd);
    pusher.onConnectionError((error) {
      print("error: ${error?.message}");
    });
    channel.bind(Env.webSocketEventChat, (event) {
      fd = true;
      print(event);
    });
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
        body: ButtonPrimary(onPressed: () async{
          getChat();
        }, texto: 'cht'),
        bottomNavigationBar:  const MenuLogged(personsChats: true),

    ),
    );
  }
}
