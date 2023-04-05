import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:the_specials_app/screens/edit_about_me/edit_about_me_translate.dart';
import 'package:the_specials_app/screens/edit_about_me/list_value_use_dropdown.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_drugs.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_medical_procedures.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/services/functions/functions.dart';
import 'package:the_specials_app/shared/state_management/cids/cids.dart';
import 'package:the_specials_app/shared/state_management/logged_user_data/logged_user_data.dart';
import 'package:the_specials_app/shared/state_management/user_data_profile/user_data_profile.dart';
import 'package:the_specials_app/shared/styles/buttons.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/languages.dart';
import 'package:the_specials_app/shared/values/routes.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class EditAboutMe extends StatefulWidget {
  const EditAboutMe({Key? key}) : super(key: key);

  @override
  State<EditAboutMe> createState() => _EditAboutMeState();
}

class _EditAboutMeState extends State<EditAboutMe> {
  final profileUserDataController =
      Get.put<UserDataProfileController>(UserDataProfileController());
  final loggedUserDataController =
      Get.put<LoggedUserDataController>(LoggedUserDataController());
  late Cids listCids;
  late ResponseListMedicalProcedures listMedicalProcedures;
  late ResponseDrugs listDrugs;

  final showLists = false.obs;
  final form = FormGroup({
    'occupation': FormControl<String>(
      validators: [Validators.required],
    ),
    'gender': FormControl<String>(validators: [Validators.required]),
    'sexual_orientation':
        FormControl<String>(validators: [Validators.required]),
    'about': FormControl<String>(validators: [Validators.required]),
  });
  final _service = ConsumeApisService();
  List<Cid> _listCidsToShow = [];
  List<MedicalProceduresData> _listMedicalProceduresToShow = [];
  List<DrgusData> _listDrugs = [];

  listGenders(Locale locale) {
    List<DropdownMenuItem<String>> list = [];
    if (locale.toString() == 'pt_BR') {
      ListValueDropdowns().listGendersPt?.forEach((item) {
        list.add(
          DropdownMenuItem(
            value: item['value'] as String,
            child: Text(item['label'] as String),
          ),
        );
      });
    }
    if (locale.toString() == 'en_US') {
      ListValueDropdowns().listGendersEn?.forEach((item) {
        list.add(
          DropdownMenuItem(
            value: item['value'] as String,
            child: Text(item['label'] as String),
          ),
        );
      });
    }
    return list;
  }

  listSexualOrientation(Locale locale) {
    List<DropdownMenuItem<String>> list = [];
    if (locale.toString() == 'pt_BR') {
      ListValueDropdowns().listSexualOrientationsPt?.forEach((item) {
        list.add(
          DropdownMenuItem(
            value: item['value'] as String,
            child: Text(item['label'] as String),
          ),
        );
      });
    }
    if (locale.toString() == 'en_US') {
      ListValueDropdowns().listSexualOrientationsEn?.forEach((item) {
        list.add(
          DropdownMenuItem(
            value: item['value'] as String,
            child: Text(item['label'] as String),
          ),
        );
      });
    }
    return list;
  }

  getDataSetValueForm() async {
    await profileUserDataController.getProfileUserData();
    form.value = profileUserDataController.savedUserDataProfile?.data?.toJson();
  }

  getListWithUseMultipleSelection() async {
    listCids = await _service.getCids();
    listMedicalProcedures = await _service.getMedicalProcedures();
    listDrugs = await _service.getDrugs();

    setState(() {
      List<Cid> localCids = [];
      List<MedicalProceduresData> localMedicalProcedures = [];
      List<DrgusData> localDrugs = [];

      profileUserDataController.savedUserDataProfile?.data?.myCids
          ?.forEach((element) {
        localCids.add(listCids.data?.firstWhere((cid) => cid.id == element.cid?.id) as Cid);
      });
      _listCidsToShow = localCids;
      profileUserDataController.savedUserDataProfile?.data?.medicalProcedures
          ?.forEach((element) {
        localMedicalProcedures.add(listMedicalProcedures.data?.firstWhere((medicalProcedure) => medicalProcedure.id == element.medicalProcedures?.id) as MedicalProceduresData);
      });
      _listMedicalProceduresToShow = localMedicalProcedures;
      profileUserDataController.savedUserDataProfile?.data?.myDrugs
          ?.forEach((element) {
        localDrugs.add(listDrugs.data?.firstWhere((drug) => drug.id == element.drug?.id) as DrgusData);
      });
      print(localDrugs);
      _listDrugs = localDrugs;
    });

    showLists(true);
    profileUserDataController.update();
  }

  updateAboutMe() async {
    var userId = profileUserDataController.savedUserDataProfile?.data?.id;
    final newArrayValue = [];
    _listCidsToShow.forEach((element) {
      newArrayValue.add(element);
    });
    // print({...form.value, 'disability': {'cids': newArrayValue}});
    var responseUpdateProfile =
        await _service.postUpdateProfile(userId, {...form.value});
    print(responseUpdateProfile.toJson);
    if (responseUpdateProfile.toJson()['status']) {
      await _service.getProfile(userId);
      await profileUserDataController.getProfileUserData();
      Functions().openSnackBar(context, DefaultColors.greenSoft,
          snackBarSuccessProfileUpdate.i18n, snackBarBtnOk.i18n);
      Navigator.pushNamed(context, RoutesApp.profile);
    } else {
      Functions().openSnackBar(context, DefaultColors.redDefault,
          snackBarErrorProfileUpdate.i18n, snackBarBtnOk.i18n);
    }
  }

  selectedCids() {

    // profileUserDataController.savedUserDataProfile?.data?.medicalProcedures
    //     ?.forEach((element) {
    //   _listMedicalProceduresToShow.add(element.medicalProcedures);
    // });
    // return _listCidsToShow;
  }
  validateLanguageReturnCid(Cid cid) {
    if(Localizations.localeOf(context).toString() == Languages.enUS) {
      return cid.descriptionEn;
    }
    if(Localizations.localeOf(context).toString() == Languages.ptBR) {
      return cid.description;

    }
  // return cid.descriptionEn;
  }
  validateLanguageReturnMedicalProcedures(MedicalProceduresData medicalProcedures) {
    if(Localizations.localeOf(context).toString() == Languages.enUS) {
      return medicalProcedures.nameEn;
    }
    if(Localizations.localeOf(context).toString() == Languages.ptBR) {
      return medicalProcedures.name;

    }
    // return cid.descriptionEn;
  }
  validateLanguageReturnDrug(DrgusData drug) {
    if(Localizations.localeOf(context).toString() == Languages.enUS) {
      return drug.nameEn;
    }
    if(Localizations.localeOf(context).toString() == Languages.ptBR) {
      return drug.name;

    }
    // return cid.descriptionEn;
  }
  searchItensCids() {
    return listCids.data
        ?.map((cid) {
          return MultiSelectItem<Cid>(cid, validateLanguageReturnCid(cid) as String);

        })
        .toList() as List<MultiSelectItem<Cid>>;
  }
  itensSelectedsForChipDisplay() {
    return _listCidsToShow.map((e) => MultiSelectItem(e, validateLanguageReturnCid(e) as String)).toList();
  }
  void _showMultiSelect(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return  MultiSelectBottomSheet(
          initialValue: _listCidsToShow,

          items: searchItensCids(),
          listType: MultiSelectListType.LIST,
          searchable: true,
          maxChildSize: 0.8,

          onConfirm: (values) {
            _listCidsToShow.clear();
            values.forEach((element) {
              print(element.toJson());
              _listCidsToShow.add(element);
            });
          },
        );
      },
    );
  }
  returnListWidgetLists() {
    List<Widget> listWidgets = [
      // Column(
      //   children: [
      //     ButtonSimulateInputSelect(onPressed: (){
      //       _showMultiSelect(context);
      //     }, texto: 'Cids'),
      //     MultiSelectChipDisplay(
      //       scroll: true,
      //       items: itensSelectedsForChipDisplay(),
      //       icon: const Icon(Icons.close),
      //     ),
      //   ],
      // ),

      MultiSelectBottomSheetField(
        title: Text(labelHintCids.i18n),
        buttonText: Text('${labelHintSelect.i18n} ${labelHintCids.i18n}'),
        buttonIcon: const Icon(Icons.arrow_drop_down),
        listType: MultiSelectListType.LIST,
        searchable: true,
        initialValue: _listCidsToShow,
        selectedItemsTextStyle: const TextStyle(color: DefaultColors.blueBrand),
        chipDisplay: MultiSelectChipDisplay(
          scroll: true,
          icon: const Icon(Icons.close),
        ),
        items: searchItensCids(),
        onConfirm: (values) {
          _listCidsToShow.clear();
          values.forEach((element) {
            print(element.toJson());
            _listCidsToShow.add(element);
          });
        },
      ),
      const SizedBox(
        height: 20,
      ),
      MultiSelectBottomSheetField(
        title: Text(labelHintMedicalProcedures.i18n),
        buttonText: Text('${labelHintSelect.i18n} ${labelHintMedicalProcedures.i18n}'),
        buttonIcon: const Icon(Icons.arrow_drop_down),
        listType: MultiSelectListType.LIST,
        searchable: true,
        chipDisplay: MultiSelectChipDisplay(
          scroll: true,
          icon: const Icon(Icons.close),
        ),
        initialValue: _listMedicalProceduresToShow,
        selectedItemsTextStyle: const TextStyle(color: DefaultColors.blueBrand),
        items: listMedicalProcedures.data
            ?.map((medicalProcedure) => MultiSelectItem<MedicalProceduresData>(
                medicalProcedure, validateLanguageReturnMedicalProcedures(medicalProcedure) as String))
            .toList() as List<MultiSelectItem<dynamic>>,
        onConfirm: (values) {
          _listMedicalProceduresToShow.clear();
          values.forEach((element) {
            _listMedicalProceduresToShow.add(element);
          });
        },
      ),
      const SizedBox(
        height: 20,
      ),
      MultiSelectBottomSheetField(
        title: Text(labelHintMedicalProcedures.i18n),
        buttonText: Text('${labelHintSelect.i18n} ${labelHintMedicalProcedures.i18n}'),
        buttonIcon: const Icon(Icons.arrow_drop_down),
        listType: MultiSelectListType.LIST,
        searchable: true,
        chipDisplay: MultiSelectChipDisplay(
          scroll: true,
          icon: const Icon(Icons.close),
        ),
        initialValue: _listDrugs,
        selectedItemsTextStyle: const TextStyle(color: DefaultColors.blueBrand),
        items: listDrugs.data
            ?.map((drug) => MultiSelectItem<DrgusData>(
            drug, validateLanguageReturnDrug(drug) as String))
            .toList() as List<MultiSelectItem<dynamic>>,
        onConfirm: (values) {
          _listDrugs.clear();
          values.forEach((element) {
            _listDrugs.add(element);
          });
        },
      ),
    ];

    return Column(children: listWidgets);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataSetValueForm();
    getListWithUseMultipleSelection();
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
                        Navigator.pushNamed(context, RoutesApp.profile);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      editAboutMeTitle.i18n,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: ReactiveFormBuilder(
                        form: () => form,
                        builder: (context, form, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                titlePersonalInfo.i18n,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: DefaultColors.blueBrand,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    ReactiveTextField(
                                        decoration: InputDecoration(
                                          hintText: labelHitOccupation.i18n,
                                        ),
                                        formControlName: 'occupation',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              '${labelHitOccupation.i18n} ${requiredMsg.i18n}'
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ReactiveDropdownField<String>(
                                        formControlName: 'gender',
                                        hint: Text(labelHitGender.i18n),
                                        items: listGenders(
                                            Localizations.localeOf(context))),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ReactiveDropdownField<String>(
                                        formControlName: 'sexual_orientation',
                                        hint:
                                            Text(labelHitSexeualOrientation.i18n),
                                        items: listSexualOrientation(
                                            Localizations.localeOf(context))),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 120,
                                      child: ReactiveTextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 8,
                                          maxLength: 500,
                                          decoration: InputDecoration(
                                            hintText: labelHitTellMore.i18n,
                                          ),
                                          formControlName: 'about',
                                          validationMessages: {
                                            ValidationMessage.required: (_) =>
                                                '${labelHitOccupation.i18n} ${requiredMsg.i18n}'
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        GetBuilder<UserDataProfileController>(
                                            builder: (_) {
                                          if (showLists.value) {
                                            return returnListWidgetLists();
                                          } else {
                                            return Text('Loading');
                                          }
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonPrimary(
                        onPressed: () {
                          updateAboutMe();
                        },
                        texto: 'Salvar')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class Animal {
  final int id;
  final String name;

  Animal({
    required this.id,
    required this.name,
  });
}