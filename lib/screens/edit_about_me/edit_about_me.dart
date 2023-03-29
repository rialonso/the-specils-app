import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:the_specials_app/screens/edit_about_me/edit_about_me_translate.dart';
import 'package:the_specials_app/screens/edit_about_me/list_value_use_dropdown.dart';
import 'package:the_specials_app/shared/styles/colors.dart';
import 'package:the_specials_app/shared/values/routes.dart';

class EditAboutMe extends StatefulWidget {
  const EditAboutMe({Key? key}) : super(key: key);

  @override
  State<EditAboutMe> createState() => _EditAboutMeState();
}

class _EditAboutMeState extends State<EditAboutMe> {
  FormGroup get form => fb.group(<String, Object>{
    'occupation': FormControl<String>(
      validators: [Validators.required],
    ),
    'gender': FormControl<String>(validators: [Validators.required]),
  });

  listGenders(Locale locale) {
    List<DropdownMenuItem<String>> list = [];
    if(locale.toString() == 'pt_BR') {
      ListValueDropdowns().listGendersPt?.forEach((item) {
        list.add(
          DropdownMenuItem(
            value: item['value'] as String,
            child: Text(item['label'] as String),
          ),
        );
      });
    }
    if(locale.toString() == 'en_US') {
      ListValueDropdowns().listGendersEn?.forEach((item) {
        list.add(
          DropdownMenuItem(
            value: item['value'] as String,
            child: Text(item['label'] as String),
          ),
        );
      });
    }
    return  list;
  }
  listSexualOrientation(Locale locale) {
    List<DropdownMenuItem<String>> list = [];
    if(locale.toString() == 'pt_BR') {
      ListValueDropdowns().listSexualOrientationsPt?.forEach((item) {
        list.add(
          DropdownMenuItem(
            value: item['value'] as String,
            child: Text(item['label'] as String),
          ),
        );
      });
    }
    if(locale.toString() == 'en_US') {
      ListValueDropdowns().listSexualOrientationsEn?.forEach((item) {
        list.add(
          DropdownMenuItem(
            value: item['value'] as String,
            child: Text(item['label'] as String),
          ),
        );
      });
    }
    return  list;
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
                  height: 20,
                ),
                ReactiveFormBuilder(
                  form: () => form,
                  builder: (context, form, child) {
                    return Column(
                      children: [
                        ReactiveTextField(
                          decoration: InputDecoration(
                            hintText: labelHitOccupation.i18n,
                          ),
                          formControlName: 'occupation',
                          validationMessages: {
                            ValidationMessage.required: (_) => '${labelHitOccupation.i18n} ${requiredMsg.i18n}'
                          }
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReactiveDropdownField<String>(
                          formControlName: 'gender',
                          hint: Text(labelHitGender.i18n),
                          items: listGenders(Localizations.localeOf(context))
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReactiveDropdownField<String>(
                            formControlName: 'gender',
                            hint: Text(labelHitGender.i18n),
                            items: listSexualOrientation(Localizations.localeOf(context))
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );  }
}
