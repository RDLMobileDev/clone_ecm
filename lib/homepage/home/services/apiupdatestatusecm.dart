import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future updateStatus(String notifId, String notifStatus, String token) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/notif_update";
  final response = await http.post(Uri.parse(url), headers: {
    "Accept": "Application/json",
    'Authorization': 'Bearer $token',
  }, body: {
    'notifecm_id': notifId,
    'notifecm_status': notifStatus,
  });

  // print(response.body);
  // if (response.body != null) {
  //   var convertData = jsonDecode(respons e.body);
  //   return convertData;
  // }

  if (response.body.isNotEmpty) {
    var convertDatatoJson = jsonDecode(response.body);
    json.decode(response.body);
    return convertDatatoJson;
  }
}
