import "package:i18n_extension/i18n_extension.dart";
const pictureTitle = "pictureTitle";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    pictureTitle: {
      "en_us": "Pictures",
      "pt_br": "Fotos"
    },
  });

  String get i18n => localize(this, _t);

}