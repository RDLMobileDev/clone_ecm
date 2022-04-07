import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future getListNotification(String idUser, String token) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/notif_review_acc?user_id=$idUser";
  final response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });
  print('Token : ${token}');
  print(response.body);

  if (response.body.isNotEmpty) {
    var convertDatatoJson = jsonDecode(response.body);
    json.decode(response.body);
    return convertDatatoJson;
  }
}
