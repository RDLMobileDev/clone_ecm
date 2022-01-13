import 'dart:convert';

import 'package:e_cm/baseurl/baseurl.dart';

import 'package:http/http.dart' as http;

class RemoveEcmCancelUser {
  Future removeEcmLast(String token, String ecmId) async {
    String url = MyUrl().getUrlDevice();

    try {
      var response =
          await http.post(Uri.parse("$url/batalkanisiecm"), headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      }, body: {
        "ecm_id": ecmId
      });

      var result = json.decode(response.body);
      return result;
    } catch (e) {
      print(e);
    }
  }
}

final removeEcmCancelUser = RemoveEcmCancelUser();
