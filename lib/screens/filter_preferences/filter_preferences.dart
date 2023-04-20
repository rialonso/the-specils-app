import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/screens/filter_preferences/translate_filter_preferences.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';
import 'package:the_specials_app/shared/styles/colors.dart';

class FilterPreferences extends StatefulWidget {
  const FilterPreferences({Key? key}) : super(key: key);

  @override
  State<FilterPreferences> createState() => _FilterPreferencesState();
}

class _FilterPreferencesState extends State<FilterPreferences> {
  final profileUserDataController =
    Get.put<UserDataProfileController>(UserDataProfileController());

  double _currentLocationValue = 10;

  boxFilterPreferences(innerWidget) {
    return Container(
      width: MediaQuery.of(context).size.width,

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: innerWidget,
    );
  }
  widgetSearchRadius() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.mode_of_travel),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                color: DefaultColors.purpleBrand,
                iconSize: 25,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 5),
              Column(
                children: [
                  Text(
                    localizationTitle.i18n,
                    style:  const TextStyle(
                      color: DefaultColors.greyMedium,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    localizationSubTitle.i18n,
                    style:  const TextStyle(
                      color: DefaultColors.greyMedium,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),

            ],
          ),
          Slider(
            value: _currentLocationValue,
            max: 5000,
            divisions: 5000,
            onChanged: (double value) {
              setState(() {
                _currentLocationValue = value;
              });
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                localizationSupportingText.i18n,

              ),
              Text(
                ' ${_currentLocationValue.round().toString()} km',
                style: const TextStyle(
                  color: DefaultColors.blueBrand,
                  fontWeight: FontWeight.w600
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  returnCardsFilters() {
    return Column(
      children: [
        boxFilterPreferences(widgetSearchRadius()),
      ],
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileUserDataController.getProfileUserData();
    _currentLocationValue = profileUserDataController.savedUserDataProfile?.data?.maxDistance.toDouble();

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
            preferredSize: const Size.fromHeight(10.0),
            // here the desired height
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              // ...
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      color: DefaultColors.blueBrand,
                      iconSize: 35,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      filterPreferencesTitle.i18n,
                      style: const TextStyle(
                        fontSize: 25,
                        color: DefaultColors.greyMedium,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                GetBuilder<UserDataProfileController>(
                    builder: (_) {
                      if (profileUserDataController.userDataUpdated.value) {
                      return returnCardsFilters();
                      } else {
                      return const Text('Loading');
                      }
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
