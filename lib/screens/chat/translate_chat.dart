import "package:i18n_extension/i18n_extension.dart";
const notLoadChatMessage = "notLoadChatMessage";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    notLoadChatMessage: {
      "en_us": "Start the conversation by saying hello",
      "pt_br": "Inicie a conversa mandando um olá"
    },
  });

  String get i18n => localize(this, _t);

}