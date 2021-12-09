import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future fillNewEmpatUpdate(
   String ecmId,
  String idMachine,
  String itemCheck,
  String standard,
  String actual,
  String note,
  String start,
  String end,
  String userId,
  String userName,
  String ecmItemId,
    String token) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/ecmstep4_update";
  final response = await http.post(Uri.parse(url), headers: {
    "Accept": "Application/json",
    'Authorization': 'Bearer $token',
  }, body: {
    'ecm_id': ecmId,
    'id_machine': idMachine,
    'item_check': itemCheck,
    'standard': standard,
    'actual': actual,
    'note': note,
    'start': start,
    'end': end,
    'user_id': userId,
    'user_name': userName,
    'ecmitem_id': ecmItemId,
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
