import "package:i18n_extension/i18n_extension.dart";
const profileTitle = "profileTitle";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    profileTitle: {
      "en_us": "Profile",
      "pt_br": "Perfil"
    },
  });

  String get i18n => localize(this, _t);

}