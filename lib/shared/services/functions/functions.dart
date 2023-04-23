import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:the_specials_app/screens/edit_about_me/list_value_use_dropdown.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_hospitals.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/services/factory/location_lat_lng_factory.dart';
import 'package:the_specials_app/shared/state_management/invalid_credentials.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';

class Functions {
  final _service = ConsumeApisService();
  late dynamic listHospitals;
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
  Future<bool> validateLocationAndGetLocation() async {
    bool servicestatus = await Geolocator.isLocationServiceEnabled();
    if(servicestatus){
      print("GPS service is enabled");
      LocationPermission permission = await Geolocator.checkPermission();
      print(permission);
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
          return false;
        }else if(permission == LocationPermission.deniedForever){
          print("'Location permissions are permanently denied");
          return false;
        }else{
          print("GPS Location service is granted");
          return true;
        }
      }else{
        print("GPS Location permission granted.");
        return true;
      }
    }else{
      print("GPS service is disabled.");
      return false;
    }

  }
  Future<dynamic> getCurrentLocation() async{
    bool locationAble = await validateLocationAndGetLocation();
    if(locationAble) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    }
  }
 Future<dynamic> getHospitals(FactoryLocationLatLng position) async{
    print(position);
     listHospitals = _service.getHospitals(
        queryParameters: {
          "lat": position.lat,
          "lng": position.lng
        }
    );
     return listHospitals;
 }
  listGenders(Locale locale) {
    List<DropdownMenuItem<String>> list = [];
    if (locale.toString() == 'pt_BR') {
      for (var item in ListValueDropdowns().listGendersPt) {
        list.add(
          DropdownMenuItem(
            value: item['value'] as String,
            child: Text(item['label'] as String),
          ),
        );
      }
    }
    if (locale.toString() == 'en_US') {
      for (var item in ListValueDropdowns().listGendersEn) {
        list.add(
          DropdownMenuItem(
            value: item['value'] as String,
            child: Text(item['label'] as String),
          ),
        );
      }
    }
    return list;
  }
  listRelationShip(Locale locale) {
    List<DropdownMenuItem<String>> list = [];
    if (locale.toString() == 'pt_BR') {
      for (var item in ListValueDropdowns().listRelationshipPt) {
        list.add(
          DropdownMenuItem(
            value: item['value'] as String,
            child: Text(item['label'] as String),
          ),
        );
      }
    }
    if (locale.toString() == 'en_US') {
      for (var item in ListValueDropdowns().listRelationshipEn) {
        list.add(
          DropdownMenuItem(
            value: item['value'] as String,
            child: Text(item['label'] as String),
          ),
        );
      }
    }
    return list;
  }

}
