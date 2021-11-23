import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future fillNewEmpatInsert(
    String ecmId,
    String partId,
    String actual,
    String note,
    String start,
    String end,
    String userId,
    String fullName,
    String ecmitemId,
    String token) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/ecmstep4_update";
  final response = await http.post(Uri.parse(url), headers: {
    "Accept": "Application/json",
    'Authorization': 'Bearer $token',
  }, body: {
    'ecm_id': ecmId,
    'part_id': partId,
    'actual': actual,
    'note': note,
    'start': start,
    'end': end,
    'user_id': userId,
    'user_name': fullName,
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
