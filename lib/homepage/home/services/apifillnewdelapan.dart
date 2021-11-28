import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future fillNewDelapan(String ecmId, String copyEngineer, String copyProduct,
    String copyOthers, String token) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/ecm_step8_insert";
  final response = await http.post(Uri.parse(url), headers: {
    "Accept": "Application/json",
    'Authorization': 'Bearer $token',
  }, body: {
    'ecm_id': ecmId,
    'ecm_copyengineer': copyEngineer,
    'ecm_copyproduct': copyProduct,
    'ecm_copyothers': copyProduct
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
