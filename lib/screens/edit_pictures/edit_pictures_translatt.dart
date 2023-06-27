import "package:i18n_extension/i18n_extension.dart";
const editPicturesTitle = "editPicturesTitle";


const buttonSave = "buttonSave";
const buttonPickImage = "buttonPickImage";
const buttonTakeImage = "buttonTakeImage";
const buttonCancel = "buttonCancel";

const snackBarSuccessImagesUpdate = "snackBarSuccessImagesUpdate";
const snackBarErrorProfileUpdate = "snackBarErrorProfileUpdate";
const snackBarBtnOk = "snackBarBtnOk";

const snackBarImagesEmpty = "snackBarImagesEmpty";

extension Localization on String {
  static const _t = Translations.from("en_us", {
    editPicturesTitle: {
      "en_us": "Edit Pictures",
      "pt_br": "Edição de imagens"
    },
    buttonSave: {
      "en_us": "Save",
      "pt_br": 'Salvar',
    },
    buttonPickImage: {
      "en_us": "Choose image",
      "pt_br": 'Escolher da galeria',
    },
    buttonTakeImage: {
      "en_us": "Take image",
      "pt_br": 'Tirar foto',
    },
    buttonCancel: {
      "en_us": "Cancel",
      "pt_br": 'Cancelar',
    },
    snackBarSuccessImagesUpdate: {
      "en_us": "Successfully saved pictures",
      "pt_br": 'Imagens salvas com sucesso',
    },
    snackBarBtnOk: {
      "en_us": "Ok",
      "pt_br": 'Entendi',
    },
    snackBarErrorProfileUpdate: {
      "en_us": "Sorry, error saving pictures",
      "pt_br": 'Desculpe, erro ao salvar imagens',
    },
    snackBarImagesEmpty: {
      "en_us": "Not image selected",
      "pt_br": 'Nenhuma imagem selecionada',
    },
  });

  String get i18n => localize(this, _t);

}