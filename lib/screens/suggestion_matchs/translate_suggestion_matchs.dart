import "package:i18n_extension/i18n_extension.dart";
const kmFromYou = "kmFromYou";
extension Localization on String {
  static const _t = Translations.from("en_us", {
    kmFromYou: {
      "en_us": "km from you",
      "pt_br": "km de você"
    },
  });

  String get i18n => localize(this, _t);

}