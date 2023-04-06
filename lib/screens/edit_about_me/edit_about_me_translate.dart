import "package:i18n_extension/i18n_extension.dart";
const editAboutMeTitle = "editAboutMeTitle";
const labelHitOccupation = "labelHitOccupation";
const titlePersonalInfo = "titlePersonalInfo";

const requiredMsg = "requiredMsg";
const labelHitGender = "labelHitGender";
const labelHitSexeualOrientation = "labelHitSexeualOrientation";
const labelHitTellMore = "labelHitTellMore";
const snackBarSuccessProfileUpdate = "snackBarSuccessProfileUpdate";
const snackBarErrorProfileUpdate = "snackBarErrorProfileUpdate";

const snackBarBtnOk = "snackBarBtnOk";
const labelHintSelect = "labelHintSelect";
const labelHintCids = "labelHintCids";
const labelHintMedicalProcedures = "labelHintMedicalProcedures";
const labelHintDrugs = "labelHintDrugs";
const labelHintHospitals = "labelHintHospitals";

const buttonSave = "buttonSave";


extension Localization on String {
  static const _t = Translations.from("en_us", {
    editAboutMeTitle: {
      "en_us": "Edit about me",
      "pt_br": "Edição sobre mim"
    },
    requiredMsg: {
      "en_us": "Required",
      "pt_br": "Obrigatória"
    },
    labelHitOccupation: {
      "en_us": "Occupation",
      "pt_br": "Profissão"
    },
    labelHitGender: {
      "en_us": "Gender",
      "pt_br": "Gênero"
    },
    labelHitSexeualOrientation: {
      "en_us": "Sexual orientation",
      "pt_br": "Orientação sexual"
    },
    titlePersonalInfo: {
      "en_us": "Personal information",
      "pt_br": "Informações pessoais"
    },
    labelHitTellMore: {
      "en_us": "Tell more about yourself",
      "pt_br": "Conte mais sobre vocē"
    },
    snackBarSuccessProfileUpdate: {
      "en_us": "Successfully saved data",
      "pt_br": 'Dados salvos com sucesso',
    },
    snackBarBtnOk: {
      "en_us": "Ok",
      "pt_br": 'Entendi',
    },
    snackBarErrorProfileUpdate: {
      "en_us": "Sorry, error saving data",
      "pt_br": 'Desculpe, erro ao salvar dados',
    },
    labelHintSelect: {
      "en_us": "Select",
      "pt_br": 'Selecione',
    },
    labelHintCids: {
      "en_us": "ICD`s",
      "pt_br": 'CID`s',
    },
    labelHintMedicalProcedures: {
      "en_us": "medical procedures",
      "pt_br": 'procedimentos médicos',
    },
    labelHintDrugs: {
      "en_us": "drugs",
      "pt_br": 'medicamentos',
    },
    labelHintHospitals: {
      "en_us": "hospitals",
      "pt_br": 'hospitais',
    },
    buttonSave: {
      "en_us": "Save",
      "pt_br": 'Salvar',
    },
  });

  String get i18n => localize(this, _t);

}