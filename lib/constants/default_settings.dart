import 'package:stokpile/constants/cloud_storage_constants.dart';
import 'package:stokpile/constants/theme_modes.dart';

abstract final class Defaults {
  static const Map<String, dynamic> userSettings = ({
    nicknameFieldName: '',
    themeSettingFieldName: systemMode,
    overdrawingSettingFieldName: false,
    notesSettingFieldName: false,
    setupCompleteFieldName: false,
  });
}
