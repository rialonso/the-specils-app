import "package:i18n_extension/i18n_extension.dart";
const settingsTitle = "settingsTitle";

const btnSettingsUpdateProfile = "btnSettingsUpdateProfile";
const btnPreferences = "btnPreferences";
const btnChangePassword = "btnChangePassword";
const btnLogout = "btnLogout";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    settingsTitle: {
      "en_us": "Settings",
      "pt_br": "Configurações",
    },
    btnSettingsUpdateProfile: {
      "en_us": "My profile",
      "pt_br": "Meu perfil",
    },
    btnPreferences: {
      "en_us": "Preferences",
      "pt_br": "Preferências",
    },
    btnChangePassword: {
      "en_us": "Change password",
      "pt_br": "Alterar senha",
    },
    btnLogout: {
      "en_us": "Logout",
      "pt_br": "Sair",
    },

  });

  String get i18n => localize(this, _t);

}