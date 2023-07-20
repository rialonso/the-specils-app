import "package:i18n_extension/i18n_extension.dart";
const notLoadItensMatches = "notLoadItensMatches";
const lastMessageImage = "lastMessageImage";
const lastMessageAudio = "lastMessageAudio";
const lastMessagePrefix = "lastMessagePrefix";
extension Localization on String {
  static const _t = Translations.from("en_us", {
    notLoadItensMatches: {
      "en_us": "You don't have any matches to chat yet.",
      "pt_br": "Você ainda não tem nenhum match para conversar"
    },
    lastMessageImage: {
      "en_us": "Picture",
      "pt_br": "Foto"
    },
    lastMessageAudio: {
      "en_us": "Audio",
      "pt_br": "Audio"
    },
    lastMessagePrefix: {
      "en_us": "You:",
      "pt_br": "Você:"
    }
  });

  String get i18n => localize(this, _t);

}