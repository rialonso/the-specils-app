import 'package:flutter/material.dart';
import 'package:the_specials_app/screens/suggestion_matchs/suggestion_matchs.dart';
import 'package:the_specials_app/screens/user_configurations/user_config.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class MenuLogged extends StatefulWidget {
  const MenuLogged({Key? key, this.routeSuggestion = false,  this.routeUserConfig = false, this.routeLikedMe = false, this.personsChats = false}) : super(key: key);
  final routeSuggestion;
  final routeUserConfig;
  final routeLikedMe;
  final personsChats;

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
              child: ButtonMenu(onPressed: () => {
                Navigator.pushNamed(context, RoutesApp.likedMe)
              }, image: 'favorite', colorIcon: changeColorRuteActive(widget.routeLikedMe))
          ),
          Flexible(
              child: ButtonMenu(onPressed: () => {
                Navigator.pushNamed(context, RoutesApp.listPersonsChats)
              }, image: 'chat_bubble',colorIcon: changeColorRuteActive(widget.personsChats))
          ),
          Flexible(
              child: ButtonMenu(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const UserConfig()));
              }, image: 'manage_accounts', colorIcon: changeColorRuteActive(widget.routeUserConfig))
          ),
        ],
      ),
    );
  }
}
