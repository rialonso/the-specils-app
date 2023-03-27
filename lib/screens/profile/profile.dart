import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_specials_app/env/env.dart';
import 'package:the_specials_app/screens/profile/profile_translate.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/services/functions/functions.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/preferences_keys.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final profileUserDataController = Get.put<UserDataProfileController>(UserDataProfileController());
  final _service = ConsumeApisService();

  UserData? profileUserData;


  waitProfileUserData() async {
    await profileUserDataController.getProfileUserData();
    return profileUserData;
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => waitProfileUserData());
  }
  @override
  void didUpdateWidget(Profile oldWidget) {
    super.didUpdateWidget(oldWidget);
    waitProfileUserData();
  }

  transformAge() {
    DateTime currentDate = DateTime.now();
    String birthDateStr = profileUserDataController.savedUserDataProfile?.data?.birthdate as String;
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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFD0E0FD), Color(0xFFE8D9FD)])
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
        body: Padding(
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
                      Navigator.pushNamed(context, RoutesApp.userConfig);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    profileTitle.i18n,
                    style: const TextStyle(
                      fontSize: 25,
                      color: DefaultColors.greyMedium,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: GetBuilder<UserDataProfileController>(
                    builder: (_) {
                    if (profileUserDataController.userDataUpdated.value) {
                      // print(profileUserDataController.userDataUpdated.value);
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('${Env.baseURLImage}${profileUserDataController?.savedUserDataProfile?.data?.profilePicture?[0]?.path?.replaceAll(r"\", r"")}') ,
                                  fit: BoxFit.cover,
                                  alignment: const Alignment(-0.3, 0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${profileUserDataController.savedUserDataProfile?.data?.name as String}, ${Functions().transformAge(profileUserDataController.savedUserDataProfile?.data?.birthdate)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: DefaultColors.purpleBrand,

                                ),
                              ),
                            ]
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '"${profileUserDataController.savedUserDataProfile?.data?.about}"',
                            style: const TextStyle(
                                fontSize: 18,
                                color: DefaultColors.blueBrand
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    pictureTitle.i18n,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      color: DefaultColors.greyMedium
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit_rounded),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    color: DefaultColors.greyMedium,
                                    iconSize: 25,
                                    onPressed: () {
                                      Navigator.pushNamed(context, RoutesApp.userConfig);
                                    },
                                  ),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text('s'),

                              )
                            ],
                          )
                        ],
                      );
                    } else {

                      return Text('loading');
                    }
                    },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
