import "package:i18n_extension/i18n_extension.dart";
const resolution = "resolution";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    resolution: {
      "en_us": "Picture resolution",
      "pt_br": "Resolucao da imagem"
    },
  });

  String get i18n => localize(this, _t);

}