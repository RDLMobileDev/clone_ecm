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

  Future removeEcmNotCompleted(String token, String idUser) async {
    // ketika cache storage device di remove
    String url = MyUrl().getUrlDevice();
    try {
      var response = await http
          .get(Uri.parse("$url/firstrunning?user_id=$idUser"), headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      });

      var result = json.decode(response.body);
      return result;
    } catch (e) {
      print(e);
    }
  }
}

final removeEcmCancelUser = RemoveEcmCancelUser();
