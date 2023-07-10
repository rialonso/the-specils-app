import "package:i18n_extension/i18n_extension.dart";
const likedMeTitle = "likedMeTitle";
const minute = "minute";
const minutes = "minutes";
const hour = "hour";
const hours = "hours";
const day = "day";
const days = "days";
const ago = "ago";
const notLoadCardsLikedMe = "notLoadCardsLikedMe";


extension Localization on String {
  static const _t = Translations.from("en_us", {
    likedMeTitle: {
      "en_us": "Likes",
      "pt_br": "Curtidas",
    },
    minute: {
      "en_us": "minute",
      "pt_br": "minuto",
    },
    minutes: {
      "en_us": "minutes",
      "pt_br": "minutos",
    },
    hour: {
      "en_us": "hour",
      "pt_br": "hora",
    },
    hours: {
      "en_us": "hours",
      "pt_br": "horas",
    },
    day: {
      "en_us": "day",
      "pt_br": "dia",
    },
    days: {
      "en_us": "days",
      "pt_br": "dias",
    },
    ago: {
      "en_us": "ago",
      "pt_br": "atrás",
    },
    notLoadCardsLikedMe: {
      "en_us": "Too bad you don't have any likes yet",
      "pt_br": "Que pena, voce ainda nao possui nenhuma curtida",
    }

  });

  String get i18n => localize(this, _t);

}