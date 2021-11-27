import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future fillNewEnam(
    String ecmId,
    String userId,
    String userName,
    String idea,
    String check,
    String repair,
    String totalcr,
    String breaks,
    String lineStart,
    String lineStop,
    String ttlLineStop,
    String costH,
    String costM,
    String costTotal,
    String outHouseH,
    String outHouseMp,
    String outHouseH2,
    String ttlOutHouse,
    String token) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/ecm_step6";
  final response = await http.post(Uri.parse(url), headers: {
    "Accept": "Application/json",
    'Authorization': 'Bearer $token',
  }, body: {
    'ecm_id': ecmId,
    'user_id': userId,
    'user_name': userName,
    'idea': idea,
    'check': check,
    'repair': repair,
    'totalcr': totalcr,
    'break': breaks,
    'linestart': lineStart,
    'linestop': lineStop,
    'ttllinestop': ttlLineStop,
    'costh': costH,
    'costm': costM,
    'costtotal': costTotal,
    'outhouseh': outHouseH,
    'outhousemp': outHouseMp,
    'outhouseh2': outHouseH2,
    'ttlouthouse': ttlOutHouse
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
