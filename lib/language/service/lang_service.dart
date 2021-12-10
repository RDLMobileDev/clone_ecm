import 'dart:convert';

import 'package:e_cm/language/model/lang_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<LangModel> getLanguageEn() async {
    var response = await rootBundle.loadString("assets/lang/lang-en.json");
    var dataLang = json.decode(response)['data'];
    var setLang = LangModel.fromJson(dataLang);
    return setLang;
  }

  Future<LangModel> getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-en.json");
    var dataLang = json.decode(response)['data'];
    var setLang = LangModel.fromJson(dataLang);
    return setLang;
  }
}

final langService = LangService();
