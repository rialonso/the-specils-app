import "package:i18n_extension/i18n_extension.dart";
const titlePreRegister = "titlePreRegister";
const email = "email";
const errorEmail = "errorEmail";
const password = "password";
const errorPassword = "errorPassword";
const btnContinue = "btnContinue";
const btnReturn = "btnReturn";
const snackBarErrorSavedLogin = "snackBarErrorSavedLogin";
const buttonSnackBarLogin = "buttonSnackBarLogin";
const titleLoginDevotee = "titleLoginDevotee";
const messageLoginDevotee = "messageLoginDevotee";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    titlePreRegister: {
      "en_us": "Register",
      "pt_br": "Registrar"
    },
    email: {
      "en_us": "E-mail",
      "pt_br": "E-mail"
    },
    errorEmail: {
      "en_us": "E-mail is required",
      "pt_br": "E-mail é obrigatório"
    },
    password: {
      "en_us": "Password",
      "pt_br": "Senha"
    },
    errorPassword: {
      "en_us": "Password is required",
      "pt_br": "Senha é obrigatório"
    },
    btnContinue: {
      "en_us": "Continue",
      "pt_br": "Continuar"
    },
    btnReturn: {
      "en_us": "Return",
      "pt_br": "Voltar"
    },
    snackBarErrorSavedLogin: {
      "en_us": "Invalid credentials",
      "pt_br": 'Credenciais inválidas',
    },
    buttonSnackBarLogin: {
      "en_us": "Ok",
      "pt_br": 'Entendi',
    },
    titleLoginDevotee: {
      "en_us": "Application for special people",
      "pt_br": 'Aplicativo para pessoas especias',
    },
    messageLoginDevotee: {
      "en_us": "Access the Devotee app, this app is dedicated to people with disabilities",
      "pt_br": 'Acesse o aplicativo Devotee, esse app é dedicado para pessoas portadoras de deficiencia',
    }
  });

  String get i18n => localize(this, _t);

}