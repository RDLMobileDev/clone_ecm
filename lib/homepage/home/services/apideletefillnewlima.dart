import 'dart:convert';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;

class DeleteFillLima {
  Future hapusItemFillLima(String token, String ecmItemId) async {
    String url = MyUrl().getUrlDevice();
    try {
      final response = await http.post(Uri.parse("$url/ecmstep5_delete"),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: {
            'ecmitem_id': ecmItemId
          });

      return json.decode(response.body);
    } catch (e) {
      print(e);
    }
  }
}

final deleteFillLima = DeleteFillLima();
