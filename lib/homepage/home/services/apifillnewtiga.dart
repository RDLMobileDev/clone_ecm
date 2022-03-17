import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String myUrl = MyUrl().getUrlDevice();

Future fillNewTiga(String why1, String why2, String why3, String why4,
    String why5, String how, String ecmId, String token) async {
  String url = "$myUrl/ecm_step3";
  final response = await http.post(Uri.parse(url), headers: {
    "Accept": "Application/json",
    'Authorization': 'Bearer $token',
  }, body: {
    'why1': why1,
    'why2': why2,
    'why3': why3,
    'why4': why4,
    'why5': why5,
    'how': how,
    'ecm_id': ecmId
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

Future getStepTigaDataForEdit(String ecmId, String token) async {
  try {
    final response = await http
        .get(Uri.parse("$myUrl/ecm_step3_get?ecm_id=$ecmId"), headers: {
      "Accept": "Application/json",
      'Authorization': 'Bearer $token',
    });

    return jsonDecode(response.body);
  } catch (e) {
    print(e);
  }
}
