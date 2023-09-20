import "package:i18n_extension/i18n_extension.dart";
const profileInfosTitle = "profileInfosTitle";
const personalInfo = "personalInfo";
const myCids = "myCids";
const myMedicalProcedures = "myMedicalProcedures";
const myDrugs = "myDrugs";
const myHospitals = "myHospitals";
const sendMessage = "sendMessage";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    profileInfosTitle: {
      "en_us": "About me",
      "pt_br": "Sobre mim"
    },
    personalInfo: {
      "en_us": "Personal Infos",
      "pt_br": "Informações pessoais"
    },
    myCids: {
      "en_us": "My ICD`s",
      "pt_br": "Minhas CID`s"
    },
    myMedicalProcedures: {
      "en_us": "Medical procedures",
      "pt_br": "Procedimentos médicos"
    },
    myDrugs: {
      "en_us": "Drugs",
      "pt_br": "Medicamentos"
    },
    myHospitals: {
      "en_us": "Hospitals",
      "pt_br": "Hospitais"
    },
    sendMessage: {
      "en_us": "Send Message",
      "pt_br": "Enviar Mensagem"
    },
  });

  String get i18n => localize(this, _t);

}