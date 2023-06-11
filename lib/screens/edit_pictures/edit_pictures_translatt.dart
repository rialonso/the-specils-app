import "package:i18n_extension/i18n_extension.dart";
const editPicturesTitle = "editPicturesTitle";


const buttonSave = "buttonSave";
const buttonPickImage = "buttonPickImage";
const buttonTakeImage = "buttonTakeImage";
const buttonCancel = "buttonCancel";


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
  });

  String get i18n => localize(this, _t);

}