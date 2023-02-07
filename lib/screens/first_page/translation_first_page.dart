import "package:i18n_extension/i18n_extension.dart";
const meetPeople = "meetPeople";
const as = "as";
const special = "special";
const you = "you";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    meetPeople: {
      "en_us": "meet someone",
      "pt_br": "conheça aqui alguém tão"
    },
    as: {
      "en_us": " as",
      "pt_br": " quanto",
    },
    special: {
      "en_us": " special",
      "pt_br": " especial",
    },
    you: {
      "en_us": " you",
      "pt_br": " você",
    },
  });

  String get i18n => localize(this, _t);

}