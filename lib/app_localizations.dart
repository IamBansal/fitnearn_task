import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppLocalization {

  late final Locale _locale;
  AppLocalization(this._locale);

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  late Map<String, String> _localizedValues;

  Future loadLanguage() async {
    String jsonStringValues =
        await rootBundle.loadString("assets/lang/${_locale.languageCode}.json");
    Map<String, dynamic> mappedValues = json.decode(jsonStringValues);

    _localizedValues =
        mappedValues.map((key, value) => MapEntry(key, value.toString()));
  }

  String? getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "ru", "es"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization appLocalization = AppLocalization(locale);
    await appLocalization.loadLanguage();
    return appLocalization;
  }

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}

class LocaleCont extends GetxController {
  Locale locale = const Locale('en', "US");

  updateLocale(Locale a) {
    locale = a;
    update();
  }
}

const String ENGLISH = "en";
const String SPANISH = "es";
const String RUSSIAN = "ru";

class Language {
  final String name;
  final String flag;
  final String languageCode;

  Language(this.name, this.flag, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language("English", "US", "en"),
      Language("Русский", 'RU', "ru"),
      Language("Española", 'AR', "es"),
    ];
  }
}
