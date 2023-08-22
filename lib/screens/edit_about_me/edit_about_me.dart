import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:the_specials_app/screens/edit_about_me/edit_about_me_translate.dart';
import 'package:the_specials_app/screens/edit_about_me/list_value_use_dropdown.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_drugs.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_hospitals.dart';
import 'package:the_specials_app/shared/interfaces/responses/response_medical_procedures.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/services/factory/location_lat_lng_factory.dart';
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
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class EditAboutMe extends StatefulWidget {
  const EditAboutMe({Key? key, this.showReturnRoute = true}) : super(key: key);
  final bool showReturnRoute;

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
  late ResponseHospitals listHospitals;

  final showLists = false.obs;
  final form = FormGroup({
    'name': FormControl<String>(
      validators: [Validators.required],
    ),
    // 'birthdate_date': FormControl<DateTime>(value: DateTime.now()),
    'birthdate':  FormControl<String>(),
    'birthdate_text':  FormControl<String>(),
    'birthdate_date':  FormControl<DateTime>(value: DateTime.now()),

    'occupation': FormControl<String>(
      validators: [Validators.required],
    ),
    'gender': FormControl<String>(validators: [Validators.required]),
    'sexual_orientation':
        FormControl<String>(validators: [Validators.required]),
    'about': FormControl<String>(validators: [Validators.required]),
    'lat': FormControl<double>(validators: [Validators.required]),
    'lng': FormControl<double>(validators: [Validators.required]),

  });
  final _service = ConsumeApisService();
  List<Cid> _listCidsToShow = [];
  List<MedicalProceduresData> _listMedicalProceduresToShow = [];
  List<DrgusData> _listDrugs = [];
  List<HospitalsData> _listHospitals = [];

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

  listSexualOrientation(Locale locale) {
    List<DropdownMenuItem<String>> list = [];
    if (locale.toString() == 'pt_BR') {
      for (var item in ListValueDropdowns().listSexualOrientationsPt) {
        list.add(
          DropdownMenuItem(
            value: item['value'] as String,
            child: Text(item['label'] as String),
          ),
        );
      }
    }
    if (locale.toString() == 'en_US') {
      for (var item in ListValueDropdowns().listSexualOrientationsEn) {
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

  getDataSetValueForm() async {
    await profileUserDataController.getProfileUserData();
    form.value = profileUserDataController.savedUserDataProfile?.data?.toJson();
    form.control('birthdate_date').value = DateTime.parse(profileUserDataController.savedUserDataProfile?.data?.birthdate as String);
    form.control('birthdate').value = DateFormat('yyyy-MM-dd').format(form.control('birthdate_date').value as DateTime);

    if (Localizations.localeOf(context).toString() == Languages.ptBR) {
      form.control('birthdate_text').value = DateFormat('dd/MM/yyyy').format(form.control('birthdate_date').value as DateTime);
    } else {
      form.control('birthdate_text').value = DateFormat('MM/dd/yyyy').format(form.control('birthdate_date').value as DateTime);

    }

  }
  formateBirthDate() {

  }

  Future<bool> getHosptalsWitCurrentLocation() async {
    final userData = profileUserDataController.savedUserDataProfile?.data;
    if (userData?.lng != null && userData?.lat != null) {
      listHospitals = await Functions().getHospitals(
          FactoryLocationLatLng(lat: userData?.lat, lng: userData?.lng));
      form.control('lat').value = userData?.lat;
      form.control('lng').value = userData?.lng;
      return true;
    } else {
      Position position = await Functions().getCurrentLocation();
      listHospitals = await Functions().getHospitals(FactoryLocationLatLng(
          lat: position.latitude, lng: position.longitude));
      form.control('lat').value = position.latitude;
      form.control('lng').value = position.longitude;
      return false;
    }
  }

  getListWithUseMultipleSelection() async {
    listCids = await _service.getCids();
    listMedicalProcedures = await _service.getMedicalProcedures();
    listDrugs = await _service.getDrugs();
    await getHosptalsWitCurrentLocation();
    setState(() {
      List<Cid> localCids = [];
      List<MedicalProceduresData> localMedicalProcedures = [];
      List<DrgusData> localDrugs = [];
      List<HospitalsData> localHospitals = [];

      profileUserDataController.savedUserDataProfile?.data?.myCids
          ?.forEach((element) {
        localCids.add(listCids.data
            ?.firstWhere((cid) => cid.id == element.cid?.id, orElse: () {
          listCids.data?.add(element.cid as Cid);
          return element.cid as Cid;
        }) as Cid);
      });
      profileUserDataController.savedUserDataProfile?.data?.medicalProcedures
          ?.forEach((element) {
        localMedicalProcedures.add(listMedicalProcedures.data?.firstWhere(
            (medicalProcedure) =>
                medicalProcedure.id == element.medicalProcedures?.id,
            orElse: () {
          listMedicalProcedures.data
              ?.add(element?.medicalProcedures as MedicalProceduresData);
          return element.medicalProcedures as MedicalProceduresData;
        }) as MedicalProceduresData);
      });
      profileUserDataController.savedUserDataProfile?.data?.myDrugs
          ?.forEach((element) {
        localDrugs.add(listDrugs.data
            ?.firstWhere((drug) => drug.id == element.drug?.id, orElse: () {
          listDrugs.data?.add(element?.drug as DrgusData);
          return element.drug as DrgusData;
        }) as DrgusData);
      });
      profileUserDataController.savedUserDataProfile?.data?.myHospitals
          ?.forEach((element) {
        localHospitals.add(listHospitals.data?.firstWhere(
            (hospital) => hospital.id == element.hospital?.id, orElse: () {
          listHospitals.data?.add(element?.hospital as HospitalsData);
          print(element?.hospital);
          return element.hospital as HospitalsData;
        }) as HospitalsData);
      });

      _listCidsToShow = localCids;
      _listMedicalProceduresToShow = localMedicalProcedures;
      _listDrugs = localDrugs;
      _listHospitals = localHospitals;
    });

    showLists(true);
    profileUserDataController.update();
  }

  updateAboutMe() async {
    var userId = profileUserDataController.savedUserDataProfile?.data?.id;
    final newArrayValueCids = [];
    final newArrayValueMedicalProcedures = [];
    final newArrayValueDrugs = [];
    final newArrayValueHosptals = [];

    for (var element in _listCidsToShow) {
      newArrayValueCids.add(element);
    }
    for (var element in _listMedicalProceduresToShow) {
      newArrayValueMedicalProcedures.add(element);
    }
    for (var element in _listDrugs) {
      newArrayValueDrugs.add(element);
    }
    for (var element in _listHospitals) {
      newArrayValueHosptals.add(element);
    }
    // print({...form.value, 'disability': {'cids': newArrayValue}});
    form.removeControl('birthdate_text');
    form.removeControl('birthdate_date');

    var responseUpdateProfile = await _service.postUpdateProfile(userId, {
      ...form.value,

      'disability': {
        'cid': newArrayValueCids,
        'medical_procedures': newArrayValueMedicalProcedures,
        'drugs': newArrayValueDrugs,
        'hospitals': newArrayValueHosptals,
      }
    });
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

  validateLanguageReturnCid(Cid cid) {
    if (Localizations.localeOf(context).toString() == Languages.enUS) {
      return cid.descriptionEn;
    }
    if (Localizations.localeOf(context).toString() == Languages.ptBR) {
      return cid.description;
    }
    // return cid.descriptionEn;
  }

  validateLanguageReturnMedicalProcedures(
      MedicalProceduresData medicalProcedures) {
    if (Localizations.localeOf(context).toString() == Languages.enUS) {
      return medicalProcedures.nameEn;
    }
    if (Localizations.localeOf(context).toString() == Languages.ptBR) {
      return medicalProcedures.name;
    }
    // return cid.descriptionEn;
  }

  validateLanguageReturnDrug(DrgusData drug) {
    if (Localizations.localeOf(context).toString() == Languages.enUS) {
      return drug.nameEn;
    }
    if (Localizations.localeOf(context).toString() == Languages.ptBR) {
      return drug.name;
    }
    // return cid.descriptionEn;
  }

  searchItensCids() {
    return listCids.data?.map((cid) {
      return MultiSelectItem<Cid>(
          cid, validateLanguageReturnCid(cid) as String);
    }).toList() as List<MultiSelectItem<Cid>>;
  }

  itensSelectedsForChipDisplay() {
    return _listCidsToShow
        .map((e) => MultiSelectItem(e, validateLanguageReturnCid(e) as String))
        .toList();
  }

  void _showMultiSelect(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet(
          initialValue: _listCidsToShow,
          items: searchItensCids(),
          listType: MultiSelectListType.LIST,
          searchable: true,
          maxChildSize: 0.8,
          onConfirm: (values) {
            _listCidsToShow.clear();
            for (var element in values) {
              _listCidsToShow.add(element);
            }
          },
        );
      },
    );
  }

  returnListWidgetLists() {
    List<Widget> listWidgets = [
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
          for (var element in values) {
            _listCidsToShow.add(element);
          }
        },
      ),
      const SizedBox(
        height: 20,
      ),
      MultiSelectBottomSheetField(
        title: Text(labelHintMedicalProcedures.i18n),
        buttonText:
            Text('${labelHintSelect.i18n} ${labelHintMedicalProcedures.i18n}'),
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
                medicalProcedure,
                validateLanguageReturnMedicalProcedures(medicalProcedure)
                    as String))
            .toList() as List<MultiSelectItem<dynamic>>,
        onConfirm: (values) {
          _listMedicalProceduresToShow.clear();
          for (var element in values) {
            _listMedicalProceduresToShow.add(element);
          }
        },
      ),
      const SizedBox(
        height: 20,
      ),
      MultiSelectBottomSheetField(
        title: Text(labelHintDrugs.i18n),
        buttonText: Text('${labelHintSelect.i18n} ${labelHintDrugs.i18n}'),
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
          for (var element in values) {
            _listDrugs.add(element);
          }
        },
      ),
      const SizedBox(
        height: 20,
      ),
      MultiSelectBottomSheetField(
        title: Text(labelHintHospitals.i18n),
        buttonText: Text('${labelHintSelect.i18n} ${labelHintHospitals.i18n}'),
        buttonIcon: const Icon(Icons.arrow_drop_down),
        listType: MultiSelectListType.LIST,
        searchable: true,
        chipDisplay: MultiSelectChipDisplay(
          scroll: true,
          icon: const Icon(Icons.close),
          onTap: (value) {
            setState(() {
              _listHospitals.remove(value);
            });
          },
        ),
        initialValue: _listHospitals,
        selectedItemsTextStyle: const TextStyle(color: DefaultColors.blueBrand),
        items: listHospitals.data
            ?.map((hospital) => MultiSelectItem<HospitalsData>(
                hospital, hospital.name as String))
            .toList() as List<MultiSelectItem<dynamic>>,
        onConfirm: (values) {
          _listHospitals.clear();
          for (var element in values) {
            _listHospitals.add(element);
          }
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
                    widget.showReturnRoute
                        ? IconButton(
                            icon: const Icon(Icons.arrow_back),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            color: DefaultColors.blueBrand,
                            iconSize: 35,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        : const Text(''),
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
                                    profileUserDataController.savedUserDataProfile?.data?.name ==
                                            null
                                        ? ReactiveTextField(
                                            decoration: InputDecoration(
                                              hintText: labelHitName.i18n,
                                            ),
                                            formControlName: 'name',
                                            validationMessages: {
                                                ValidationMessage.required: (_) =>
                                                    '${labelHitName.i18n} ${requiredMsg.i18n}'
                                              })
                                        : const Text(''),
                                    profileUserDataController.savedUserDataProfile?.data?.birthdate == null
                                        ? ReactiveDatePicker(
                                            formControlName: 'birthdate_date',
                                            firstDate: DateTime(DateTime.now().year - 100, DateTime.now().month, DateTime.now().day),
                                            lastDate: DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day),
                                            builder: (BuildContext context, ReactiveDatePickerDelegate<dynamic>picker, Widget? child) {
                                              Future.delayed(Duration.zero, () async {
                                                if (picker.value != null) {
                                                  setState(() {
                                                    // print();
                                                    form.control('birthdate').value = DateFormat('yyyy-MM-dd').format(picker.value as DateTime);

                                                    if (Localizations.localeOf(context).toString() == Languages.ptBR) {
                                                      form.control('birthdate_text').value = DateFormat('dd/MM/yyyy').format(picker.value as DateTime);
                                                    } else {
                                                      form.control('birthdate_text').value = DateFormat('MM/dd/yyyy').format(picker.value as DateTime);

                                                    }
                                                  });
                                                }
                                              });
                                              return SizedBox(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: ReactiveTextField(
                                                          decoration: InputDecoration(
                                                            suffixIcon: IconButton(
                                                              onPressed: picker.showPicker,

                                                              icon: const Icon(Icons.date_range),
                                                            ),
                                                            hintText: labelHitBirthDate.i18n,
                                                          ),
                                                          formControlName: 'birthdate_text',
                                                          validationMessages: {
                                                            ValidationMessage
                                                                    .required:
                                                                (_) =>
                                                                    '${labelHitBirthDate.i18n} ${requiredMsg.i18n}'
                                                          },
                                                        onTap: (str) => picker.showPicker,
                                                        readOnly: true,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            // decoration: const InputDecoration(
                                            //   labelText: 'dstt',
                                            //   border: OutlineInputBorder(),
                                            //   helperText: '',
                                            //   suffixIcon: Icon(Icons.watch_later_outlined),
                                            // ),
                                          )
                                        : const Text(''),
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
                                        hint: Text(
                                            labelHitSexeualOrientation.i18n),
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
                                            return Container(
                                                color: Colors.transparent,
                                                child:  Center(child: CircularProgressIndicator(color: DefaultColors.purpleBrand, backgroundColor: Colors.transparent,)));
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
                        texto: buttonSave.i18n)
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
