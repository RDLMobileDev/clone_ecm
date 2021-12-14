import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future getFillNewEmpat(String ecmId, String userId, String token) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/ecmstep4_get?ecm_id=$ecmId&user_id=$userId";
  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });
  print('Token : ${token}');
  print(response);

  if (response.body.isNotEmpty) {
    var convertDatatoJson = jsonDecode(response.body);
    json.decode(response.body);
    return convertDatatoJson;
  }
}

Future getFillLimaItem(String ecmItemId, String idUser, String token) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/ecmstep5_getid?ecmitem_id=$ecmItemId&user_id=$idUser";
  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });

  if (response.body.isNotEmpty) {
    var convertDatatoJson = jsonDecode(response.body);
    print("data item repair step 5");
    print(convertDatatoJson);
    json.decode(response.body);
    return convertDatatoJson;
  }
}
