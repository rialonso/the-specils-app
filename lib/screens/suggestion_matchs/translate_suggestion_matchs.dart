import "package:i18n_extension/i18n_extension.dart";
const kmFromYou = "kmFromYou";
const messageToEmptyCards = "messageToEmptyCards";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    kmFromYou: {
      "en_us": "km from you",
      "pt_br": "km de você"
    },
    messageToEmptyCards: {
      "en_us": "Unfortunately, we couldn't find any person suggestions for you. Try to increase your interests",
      "pt_br": "Infelizmente nao encontramos nenhuma sugestão de pessoa para voce. Tenta aumentar seus interesses"
    },
  });

  String get i18n => localize(this, _t);

}