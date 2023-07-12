import "package:i18n_extension/i18n_extension.dart";
const notLoadItensMatches = "notLoadItensMatches";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    notLoadItensMatches: {
      "en_us": "You don't have any matches to chat yet.",
      "pt_br": "Você ainda não tem nenhum match para conversar"
    },
  });

  String get i18n => localize(this, _t);

}