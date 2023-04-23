import "package:i18n_extension/i18n_extension.dart";
const filterPreferencesTitle = "filterPreferencesTitle";
const localizationTitle = "localizationTitle";
const localizationSubTitle = "localizationSubTitle";
const localizationSupportingText = "localizationSupportingText";
const genrePreferencesTitle = "genrePreferencesTitle";
const genrePreferencesSubTitle = "genrePreferencesSubTitle";
const labelHitGender = "labelHitGender";
const labelHintRelationship = "labelHintRelationship";
const ageTitle = "ageTitle";
const ageSubTitle = "ageSubTitle";
const ageMin = "ageMin";
const ageMax = "ageMax";
const years = "years";

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
    },
    genrePreferencesTitle: {
      "en_us": "User preferences",
      "pt_br": "Preferências de usuário",
    },
    genrePreferencesSubTitle: {
      "en_us": "Relationship and genre preferences",
      "pt_br": "Preferências de gênero e tipo de relacionamento",
    },
    labelHitGender: {
      "en_us": "Gender",
      "pt_br": "Gênero"
    },
    labelHintRelationship: {
      "en_us": "Relationship",
      "pt_br": "Tipo de relacionamento"
    },
    ageTitle: {
      "en_us": "Age",
      "pt_br": "Idade"
    },
    ageSubTitle: {
      "en_us": "Age range you would like",
      "pt_br": "Intervalo de idade que você deseja"
    },
    ageMin: {
      "en_us": "Minimum age",
      "pt_br": "Idade mínima "
    },
    ageMax: {
      "en_us": "Maximum age",
      "pt_br": "Idade máxima"
    },
    years: {
      "en_us": "Years",
      "pt_br": "Anos"
    },
  });

  String get i18n => localize(this, _t);

}