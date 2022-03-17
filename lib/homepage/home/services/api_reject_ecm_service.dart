import 'dart:convert';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;

Future postAlasanTolakTL(Map<String, dynamic> params, String token) async {
  String baseUrl = MyUrl().getUrlDevice();

  final response = await http.post(Uri.parse("$baseUrl/alasantolak"),
      headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      },
      body: params);

  print(response.body);

  if (response.body.isNotEmpty) {
    var convertDatatoJson = jsonDecode(response.body);
    json.decode(response.body);

    print(response.body);
    return convertDatatoJson;
  }
}
