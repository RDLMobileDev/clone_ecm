import 'dart:convert';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;

Future checkEcmRejectedByTL(String idUser, String token) async {
  String url = MyUrl().getUrlDevice();

  final response = await http.post(Uri.parse("$url/cekecmrejected"),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {"user_id": idUser});

  return jsonDecode(response.body);
}
