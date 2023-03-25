import 'package:flutter/material.dart';
import 'package:the_specials_app/screens/suggestion_matchs/suggestion_matchs.dart';
import 'package:the_specials_app/screens/user_configurations/user_config.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';

class MenuLogged extends StatefulWidget {
  const MenuLogged({Key? key, this.routeSuggestion = false,  this.routeUserConfig = false}) : super(key: key);
  final routeSuggestion;
  final routeUserConfig;
  @override
  State<MenuLogged> createState() => _MenuLoggedState();
}

class _MenuLoggedState extends State<MenuLogged> {
  changeColorRuteActive(routeActive) {
    if(routeActive) {
      return DefaultColors.blueBrand;
    } else {
      return DefaultColors.greyMedium;
    }

  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          Flexible(
              child: ButtonMenu(onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SuggestionMatchs()))
              }, image: 'contact_page', colorIcon: changeColorRuteActive(widget.routeSuggestion))
          ),
          Flexible(
              child: ButtonMenu(onPressed: () => {}, image: 'favorite')
          ),
          Flexible(
              child: ButtonMenu(onPressed: () => {}, image: 'chat_bubble')
          ),
          Flexible(
              child: ButtonMenu(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> UserConfig()));
              }, image: 'manage_accounts', colorIcon: changeColorRuteActive(widget.routeUserConfig))
          ),
        ],
      ),
    );
  }
}
