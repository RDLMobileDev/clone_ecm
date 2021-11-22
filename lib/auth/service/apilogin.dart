import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future loginUser(String emailKey, String passwordKey, String deviceKey,
    String versionKey) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/login";
  final response = await http.post(Uri.parse(url), headers: {
    "Accept": "Application/json"
  }, body: {
    'email': emailKey,
    'password': passwordKey,
    'device_key': deviceKey,
    'version_name': versionKey
  });

  // print(response.body);
  // if (response.body != null) {
  //   var convertData = jsonDecode(response.body)['data'];
  //   return convertData;
  // }

  if (response.body.isNotEmpty) {
    var convertDatatoJson = jsonDecode(response.body);
    json.decode(response.body);
    return convertDatatoJson;
  }
}
