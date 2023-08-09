import "package:i18n_extension/i18n_extension.dart";
const buttonTakeNewPictureMessage = "buttonTakeNewPictureMessage";
const buttonConfirm = "buttonConfirm";
const lastMessageAudio = "lastMessageAudio";
const lastMessagePrefix = "lastMessagePrefix";
extension Localization on String {
  static const _t = Translations.from("en_us", {
    buttonTakeNewPictureMessage: {
      "en_us": "Repeat",
      "pt_br": "Repetir"
    },
    buttonConfirm: {
      "en_us": "Confirm",
      "pt_br": "Confirmar"
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