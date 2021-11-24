import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future fillNewEmpatDelete(String ecmitemId, String token) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/ecmstep4_delete";
  final response = await http.post(Uri.parse(url), headers: {
    "Accept": "Application/json",
    'Authorization': 'Bearer $token',
  }, body: {
    'ecmitem_id': ecmitemId
  });

  // print(response.body);
  // if (response.body != null) {
  //   var convertData = jsonDecode(response.body);
  //   return convertData;
  // }

  if (response.body.isNotEmpty) {
    var convertDatatoJson = jsonDecode(response.body);
    json.decode(response.body);
    return convertDatatoJson;
  }
}
