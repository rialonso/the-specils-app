import "package:i18n_extension/i18n_extension.dart";
const filterPreferencesTitle = "filterPreferencesTitle";
const localizationTitle = "localizationTitle";
const localizationSubTitle = "localizationSubTitle";
const localizationSupportingText = "localizationSupportingText";


extension Localization on String {
  static const _t = Translations.from("en_us", {
    filterPreferencesTitle: {
      "en_us": "Preferences",
      "pt_br": "Preferências",
    },
    localizationTitle: {
      "en_us": "Localization",
      "pt_br": "Localização",
    },
    localizationSubTitle: {
      "en_us": "Search range",
      "pt_br": "Raio de busca",
    },
    localizationSupportingText: {
      "en_us": "looking for users up to",
      "pt_br": "Procurando usuários até",
    }
  });

  String get i18n => localize(this, _t);

}