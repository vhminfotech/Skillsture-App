import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'localization_en.dart';

class MyLocalizationsDelegate
    extends LocalizationsDelegate<Localization> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
    'en',
  ].contains(locale.languageCode);

// @override
//   bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) => _load(locale);

  static Future<Localization> _load(Locale locale) async {
    final String name = (locale.countryCode == null || locale.countryCode.isEmpty) ? locale.languageCode : locale;

    final localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;

    // if( locale.languageCode == "fr" ) {
    //   return LocalizationFR();
    // } else {
    //   return LocalizationEN();
    // }

    return LocalizationEN();
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}


abstract class Localization {
  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }


  String get internetNotConnected;

  String get email;
  String get name;
  String get mobile;
  String get forgotPassword;
  String get loginTitle;
  String get signInTitle;
  String get password;
  String get confirmPassword;
  String get signIn;


  String get msgEnterAddress;
  String get msgEnterValidAddress;
  String get msgEnterName;
  String get msgEnterMobile;
  String get appName;
  String get ok;
  String get alertPermissionNotRestricted;
  String get cancel;
  String get errorValidMobileNumber;
  String get errorPassword;
  String get errorValidPassword;
  String get errorConfirmPassword;
  String get errorDiffPassword;








}