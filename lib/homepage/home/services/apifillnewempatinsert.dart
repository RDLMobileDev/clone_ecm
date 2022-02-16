import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future fillNewEmpatInsert(
    // String token,
    String ecmId,
    String idMachine,
    String itemCheck,
    String standard,
    String actual,
    String note,
    String start,
    String end,
    String userId,
    String userName) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/ecmstep4_insert";
  final response = await http.post(Uri.parse(url), body: {
    'ecm_id': ecmId,
    'id_machine': idMachine,
    'item_check': itemCheck,
    'standard': standard,
    'actual': actual,
    'note': note,
    'start': start,
    'end': end,
    'user_id': userId,
    'user_name': userName
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
