import "package:i18n_extension/i18n_extension.dart";
const editAboutMeTitle = "editAboutMeTitle";
const labelHitOccupation = "labelHitOccupation";
const requiredMsg = "requiredMsg";
const labelHitGender = "labelHitGender";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    editAboutMeTitle: {
      "en_us": "Edit about me",
      "pt_br": "Edição sobre mim"
    },
    requiredMsg: {
      "en_us": "Required",
      "pt_br": "Obrigatória"
    },
    labelHitOccupation: {
      "en_us": "Occupation",
      "pt_br": "Profissão"
    },
    labelHitGender: {
      "en_us": "Gender",
      "pt_br": "Gênero"
    }
  });

  String get i18n => localize(this, _t);

}