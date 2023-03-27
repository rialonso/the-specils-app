import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_specials_app/shared/state_management/invalid_credentials.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';

class Functions {
  mapUserData(String stringUserData) {
    try {
      Map<String,dynamic> mapUser = jsonDecode(stringUserData!);
      UserData user = UserData.fromJson(mapUser);
      return user;
    } catch (e) {
      print(e);
    }

  }
  //jsonDecode(invalidCredentials!)
  mapInvalidCredentials(String invalidCredentials) {
    try {
      Map<String,dynamic> mapUser = jsonDecode(invalidCredentials);
      InvalidCredentials reponse = InvalidCredentials.fromJson(mapUser);
      return reponse;
    } catch (e) {
      print(e);
    }
  }
  openSnackBar(BuildContext contextWid, Color color, String content, String buttonLabel) {
    return  ScaffoldMessenger.of(contextWid).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(content),
        action: SnackBarAction(
          textColor: Colors.white,
          label: buttonLabel,
          onPressed: () {
            // Code to execute.
          },
        ),
        width: MediaQuery.of(contextWid).size.width * 0.8, // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
  transformAge(userBirthdate) {
    DateTime currentDate = DateTime.now();
    String birthDateStr = userBirthdate as String;
    DateTime? birthDate = DateTime.tryParse(birthDateStr);
    var year =  birthDate?.year;
    var month = birthDate?.month;
    var day = birthDate?.day;
    var age = currentDate.year - year!;
    if (currentDate.month < month! || (currentDate.month < month! == month && currentDate.day < day!)) {
      age--;
    }
    return age;
  }
}
