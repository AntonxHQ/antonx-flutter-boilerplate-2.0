import 'package:get/get.dart';

class LocalizationService extends Translations {
  static getLocalizedKey(String key) {
    String currentLanguageCode = Get.locale!.languageCode;
    print('Localized key is: ${key}_$currentLanguageCode');
    return '${key}_$currentLanguageCode';
  }

  @override
  Map<String, Map<String, String>> get keys {
    const Map<String, String> lang_en = {
      "hello": "Hello world!",
    };

    const Map<String, String> lang_ar = {
      "hello": "!مرحبا بالعالم",
    };

    return {
      'en': lang_en,
      'ar': lang_ar,
    };
  }
}
