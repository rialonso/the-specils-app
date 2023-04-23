import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:the_specials_app/screens/edit_about_me/list_value_use_dropdown.dart';
import 'package:the_specials_app/screens/filter_preferences/translate_filter_preferences.dart';
import 'package:the_specials_app/shared/services/functions/functions.dart';
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
  final form = FormGroup({
    'target_gender': FormControl<String>(validators: [Validators.required]),
    'relationship_type': FormControl<String>(validators: [Validators.required]),

  });
  double _currentLocationValue = 10;
  double _currentAgeMin = 18;
  double _currentAgeMax = 100;

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
  widgetTitleSubAndIcon(IconData icon, String title, String subTitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(icon),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          color: DefaultColors.purpleBrand,
          iconSize: 25,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:  const TextStyle(
                  color: DefaultColors.greyMedium,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                  color: DefaultColors.greyMedium,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
  widgetSearchRadius() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          widgetTitleSubAndIcon(Icons.mode_of_travel, localizationTitle.i18n, localizationSubTitle.i18n),
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
  widgetGenrePreferences() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ReactiveFormBuilder(
        form: () => form,
        builder: (BuildContext context, FormGroup formGroup, Widget? child) {
          return  Column(
            children: [
              widgetTitleSubAndIcon(Icons.tune, genrePreferencesTitle.i18n, genrePreferencesSubTitle.i18n),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,10,15,10),
                child: Column(
                  children: [
                    ReactiveDropdownField<String>(
                        formControlName: 'target_gender',
                        hint: Text(labelHitGender.i18n),
                        items: Functions().listGenders(
                            Localizations.localeOf(context))),
                    const SizedBox(
                      height: 10,
                    ),
                    ReactiveDropdownField<String>(
                        formControlName: 'relationship_type',
                        hint: Text(labelHintRelationship.i18n),
                        items: Functions().listRelationShip(
                            Localizations.localeOf(context))),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  widgetAgeMinMax() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          widgetTitleSubAndIcon(Icons.calendar_month, ageTitle.i18n, ageSubTitle.i18n),
          Slider(
            value: _currentAgeMin < 18 || _currentAgeMin > 100 ? 18: _currentAgeMin,
            min: 18,
            max: 120,
            divisions: 100,
            onChanged: (double value) {
              setState(() {
                _currentAgeMin = value;
              });
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' ${ageMin.i18n}${_currentAgeMin.round().toString()} ${years.i18n}',
                style: const TextStyle(
                    color: DefaultColors.greyMedium,
                    fontWeight: FontWeight.w600
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Slider(
            value: _currentAgeMax,
            min: 18,
            max: _currentAgeMax > 100 ? _currentAgeMax : 100,
            divisions: 100,
            onChanged: (double value) {
              setState(() {
                _currentAgeMax = value;
              });
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' ${ageMax.i18n} ${_currentAgeMax.round().toString()} ${years.i18n}',
                style: const TextStyle(
                    color: DefaultColors.greyMedium,
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
        const SizedBox(height: 20,),
        boxFilterPreferences(widgetGenrePreferences()),
        const SizedBox(height: 20,),
        boxFilterPreferences(widgetAgeMinMax()),

      ],
    );
  }
  getProfileData() async {
    await profileUserDataController.getProfileUserData();
    _currentLocationValue = profileUserDataController.savedUserDataProfile?.data?.maxDistance.toDouble();
    _currentAgeMin = profileUserDataController.savedUserDataProfile?.data?.ageMin?.toDouble() as double;
    _currentAgeMax = profileUserDataController.savedUserDataProfile?.data?.ageMax?.toDouble() as double;
    print('age min: ${_currentAgeMin}, ${_currentAgeMax}');
    form.value = profileUserDataController.savedUserDataProfile?.data?.toJson();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();

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
