import "package:i18n_extension/i18n_extension.dart";
const kmFromYou = "kmFromYou";
const messageToEmptyCards = "messageToEmptyCards";
const resetDislikes = "resetDislikes";
const resetDislikesText = "resetDislikesText";
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
    resetDislikesText: {
      "en_us": "Would you like reset list with disliked? ",
      "pt_br": "Você gostaria de resetar a lista que teve dislikes?"
    },
    resetDislikes: {
      "en_us": "Reset list",
      "pt_br": "Resetar lista"
    }
  });

  String get i18n => localize(this, _t);

}