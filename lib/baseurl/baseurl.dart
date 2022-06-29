import 'dart:convert';
import 'package:e_cm/util/shared_prefs_util.dart';
import 'package:http/http.dart' as http;

class MyUrl {
  String versionNumber = '1.0.3';
  final String _url = "https://app.ragdalion.com/ecm_client/api";

  String getUrlDevice() {
    return _url;
  }

  postData(data, apiUrl) async {
    var fullUrl = _url + "/" + apiUrl;
    final response = await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());

    return json.decode(response.body);
  }

  getData(apiUrl) async {
    var fullUrl = _url + "/" + apiUrl;
    final response = await http.get(Uri.parse(fullUrl), headers: _setHeaders());

    return json.decode(response.body);
  }

  Map<String, String> _setHeaders() {
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPrefsUtil.getTokenUser()}'
    };
  }

  String getVersion() {
    return versionNumber;
  }
}
