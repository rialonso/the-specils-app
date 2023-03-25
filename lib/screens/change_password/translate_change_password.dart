import "package:i18n_extension/i18n_extension.dart";
const titleChangePassword = "titleChangePassword";
const oldPassword = "oldPassword";
const newPassword = "newPassword";
const savePassword = "savePassword";
const snackBarSuccessSaved = "snackBarSuccessSaved";
const snackBarErrorSaved = "snackBarErrorSaved";
const buttonSnackBar = "buttonSnackBar";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    titleChangePassword: {
      "en_us": "Change password",
      "pt_br": "Alterar senha",
    },
    oldPassword: {
      "en_us": "Old password",
      "pt_br": "Senha antiga",
    },
    newPassword: {
      "en_us": "New password",
      "pt_br": 'Nova senha',
    },
    savePassword: {
      "en_us": "Save",
      "pt_br": 'Salvar',
    },
    snackBarSuccessSaved: {
      "en_us": "Password is changed",
      "pt_br": 'Senha atualizada com sucesso',
    },
    snackBarErrorSaved: {
      "en_us": "Invalid credentials",
      "pt_br": 'Credenciais inválidas',
    },
    buttonSnackBar: {
      "en_us": "Ok",
      "pt_br": 'Entendi',
    }
  });

  String get i18n => localize(this, _t);

}