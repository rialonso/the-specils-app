import "package:i18n_extension/i18n_extension.dart";
const login = "login";
const email = "email";
const errorEmail = "errorEmail";
const password = "password";
const errorPassword = "errorPassword";
const btnSignin = "btnSignin";
const createAccount = "createAccount";
const rememberPassword = "rememberPassword";
const snackBarErrorSavedLogin = "snackBarErrorSavedLogin";
const buttonSnackBarLogin = "buttonSnackBarLogin";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    login: {
      "en_us": "Login",
      "pt_br": "Entrar"
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
    btnSignin: {
      "en_us": "Sign in",
      "pt_br": "Entrar"
    },
    createAccount: {
      "en_us": "Create account",
      "pt_br": "Criar conta"
    },
    rememberPassword: {
      "en_us": "Remember my password",
      "pt_br": "Lembrar minha senha"
    },
    snackBarErrorSavedLogin: {
      "en_us": "Invalid credentials",
      "pt_br": 'Credenciais inválidas',
    },
    buttonSnackBarLogin: {
      "en_us": "Ok",
      "pt_br": 'Entendi',
    }
  });

  String get i18n => localize(this, _t);

}