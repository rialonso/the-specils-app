import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/shared/blocs/login_bloc.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';

class SuggestionMatchs extends StatefulWidget {
  const SuggestionMatchs({super.key, this.dataD});
  final dynamic dataD;
  @override
  State<SuggestionMatchs> createState() => _SuggestionMatchs();
}

class _SuggestionMatchs extends State<SuggestionMatchs> {
  final LoginBloc _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoggedUserDataController>(
      init: LoggedUserDataController(),
      builder: (_) => Scaffold(
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
            children: [ButtonPrimary(onPressed: () {
              _.getUserData();
              print('d');
            }, texto: 'ss')],
          ),
        ),
      ),
    );
  }
}
