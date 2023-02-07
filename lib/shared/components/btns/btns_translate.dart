import "package:i18n_extension/i18n_extension.dart";
const btnCreateAccount = "btnCreateAccount";
const btnLogin = "btnLogin";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    btnCreateAccount: {
      "en_us": "Create account",
      "pt_br": "Criar conta",
    },
    btnLogin: {
      "en_us": "Login",
      "pt_br": "Entrar",
    },
  });

  String get i18n => localize(this, _t);

}