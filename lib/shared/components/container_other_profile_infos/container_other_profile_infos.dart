import 'dart:io';

import 'package:flutter/material.dart';
import 'package:the_specials_app/shared/components/container_profile_infos/container_profile_infos_translate.dart';
import 'package:the_specials_app/shared/components/icon_text/icon_text.dart';
import 'package:the_specials_app/shared/state_management/other_profile_data/other_profile_data.dart';
import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:get/get.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class ContainerOtherProfileInfos extends StatefulWidget {
  const ContainerOtherProfileInfos({Key? key}) : super(key: key);

  @override
  State<ContainerOtherProfileInfos> createState() => _ContainerOtherProfileInfosState();
}

class _ContainerOtherProfileInfosState extends State<ContainerOtherProfileInfos> {
  final profileUserDataController = Get.put<OtherProfileDataController>(OtherProfileDataController());
  Data? otherProfileData;
  validateData(IconData icon, String textShow) {
    if(textShow != '' && textShow != null) {
      return IconText(iconShow: icon, textShow: textShow,);
    }
    return SizedBox();
  }
  returnListWidgetText(List<MyCids>? cids, Locale locale) {
    List<Widget> suggestionCardsWidget = [];
    if(locale.toString() == 'pt_BR') {
      cids?.forEach((cid) {
        suggestionCardsWidget.add(Text('\u2022 ${cid.cid?.description ?? cid.cid?.descriptionEn}'));
      });
    }
    if (locale.toString() == 'en_US') {
      cids?.forEach((cid) {
        suggestionCardsWidget.add(Text('\u2022 ${cid.cid?.descriptionEn ?? cid.cid?.description}'));
      });
    }
    return  suggestionCardsWidget;
  }
  returnListMedicalProceduresWidgetText(List<MedicalProcedures>? list, Locale locale) {
    List<Widget> listWidgets = [];
    list?.forEach((medical) {
      if(locale.toString() == 'pt_BR') {
        listWidgets.add(Text('\u2022 ${medical.medicalProcedures?.name ?? medical.medicalProcedures?.nameEn}'));
      }
      if (locale.toString() == 'en_US') {
        listWidgets.add(Text('\u2022 ${medical.medicalProcedures?.nameEn ?? medical.medicalProcedures?.name}'));
      }
    });
    return  listWidgets;
  }
  returnListDrugsWidgetText(List<MyDrugs>? list, Locale locale) {
    List<Widget> listWidgets = [];
    list?.forEach((medical) {
      if(locale.toString() == 'pt_BR') {
        listWidgets.add(Text('\u2022 ${medical.drug?.name ?? medical.drug?.nameEn}}'));
      }
      if (locale.toString() == 'en_US') {
        listWidgets.add(Text('\u2022 ${medical.drug?.nameEn ?? medical.drug?.name}'));
      }
    });
    return  listWidgets;
  }
  returnListHospitalsWidgetText(List<MyHospitals>? list, Locale locale) {
    List<Widget> listWidgets = [];
    list?.forEach((medical) {
      listWidgets.add(Text('\u2022 ${medical.hospital?.name}'));
    });
    return  listWidgets;
  }
  returnSpecifyList(list, locale) {
    switch(list.runtimeType) {
      case List<MyCids>: {
        // statements;
        return returnListWidgetText(list, locale);
      }
      case List<MedicalProcedures>: {
      // statements;
        return returnListMedicalProceduresWidgetText(list, locale);
      }
      case List<MyDrugs>: {
        // statements;
        return returnListDrugsWidgetText(list, locale);
      }
      case List<MyHospitals>: {
        // statements;
        return returnListHospitalsWidgetText(list, locale);
      }
      default: {
        //statements;
      }
      break;
    }
  }
  validateDataToShowListWidgets(String title, List<dynamic>? list, Locale locale) {
    if(list != null && list.isNotEmpty) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(
              title.i18n,
              style: const TextStyle(
                  color: DefaultColors.blueBrand,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.start,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: returnSpecifyList(list, locale),
              ),
            )
          ],
        ),
      );
    }
    return SizedBox();

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('did2');

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    otherProfileData = profileUserDataController.savedUserDataProfile!.data;
    print('nit');
  }
  @override
  void didUpdateWidget(covariant ContainerOtherProfileInfos oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('did');
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        personalInfo.i18n,
                        style: const TextStyle(
                          color: DefaultColors.blueBrand,
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            validateData(Icons.work, otherProfileData?.occupation != '' && otherProfileData?.occupation != null? otherProfileData?.occupation as String: ''),
                            validateData(Icons.person_pin, otherProfileData?.gender != '' && otherProfileData?.gender != null? otherProfileData?.gender as String: ''),
                            validateData(Icons.loyalty, otherProfileData?.sexualOrientation != '' && otherProfileData?.sexualOrientation != null? otherProfileData?.sexualOrientation as String: '')


                          ],
                        ),
                      )
                    ],
                  ),
                  validateDataToShowListWidgets(myCids,profileUserDataController?.savedUserDataProfile?.data?.myCids, Localizations.localeOf(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  validateDataToShowListWidgets(myMedicalProcedures, profileUserDataController?.savedUserDataProfile?.data?.medicalProcedures, Localizations.localeOf(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  validateDataToShowListWidgets(myDrugs, profileUserDataController?.savedUserDataProfile?.data?.myDrugs, Localizations.localeOf(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  validateDataToShowListWidgets(myHospitals, profileUserDataController?.savedUserDataProfile?.data?.myHospitals, Localizations.localeOf(context)),

                ],
              ),
            ),

        )
      ],
    );
  }
}
