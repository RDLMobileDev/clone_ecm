import 'dart:convert';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;

class ListTmService {
  Future<List> getListTmName(String token, String idUser) async {
    String url = MyUrl().getUrlDevice();

    print(idUser);

    try {
      var response =
          await http.get(Uri.parse("$url/get_tm?id_user=$idUser"), headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      });

      return json.decode(response.body)['data'];
    } catch (e) {
      print(e);
      return [];
    }
  }
}

final listTmService = ListTmService();
