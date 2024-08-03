// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class AppLocalizations {
//   AppLocalizations(this.locale);

//   final Locale locale;

//   static AppLocalizations? of(BuildContext context) {
//     return Localizations.of<AppLocalizations>(context, AppLocalizations);
//   }

//   static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

//   String? get imageToText {
//     return _localizedStrings['imageToText'];
//   }

//   String? get noTextAvailable {
//     return _localizedStrings['noTextAvailable'];
//   }

//   Map<String, String> _localizedStrings = {};

//   Future<void> load() async {
//     final String jsonString = await DefaultAssetBundle.of(context).loadString('lib/l10n/intl_${locale.languageCode}.arb');
//     final Map<String, dynamic> jsonMap = json.decode(jsonString);
//     _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
//   }
// }

// class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
//   const _AppLocalizationsDelegate();

//   @override
//   bool isSupported(Locale locale) {
//     return ['en', 'id', 'ms'].contains(locale.languageCode);
//   }

//   @override
//   Future<AppLocalizations> load(Locale locale) async {
//     final localizations = AppLocalizations(locale);
//     await localizations.load();
//     return localizations;
//   }

//   @override
//   bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
// }
