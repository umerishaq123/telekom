

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {

  Locale? _appLocale ;
  Locale? get appLocale => _appLocale ;


  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = const Locale('en');
      return null;
    }
    String local = prefs.getString('language_code') ?? 'en';
    _appLocale = Locale(local.toString());
    return null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type ==const Locale("en")) {
      print(type);
      _appLocale =const Locale("en");
      await prefs.setString('language_code', 'en');
      // await prefs.setString('countryCode', 'en');
    } else if(type ==const Locale("ms")) {
print(type);
      _appLocale =const Locale("ms");
      await prefs.setString('language_code', 'ms');
      // await prefs.setString('countryCode', 'ms');
    }else {
      print(type);
      _appLocale = const Locale("id");
      await prefs.setString('language_code', 'id');
      // await prefs.setString('countryCode', 'id');
    }
    notifyListeners();
  }
}



