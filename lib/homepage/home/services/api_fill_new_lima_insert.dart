import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future fillNewLimaInsert(
    {String? ecmItemId,
    String? note,
    String? start,
    String? end,
    String? userId,
    String? repairMessage,
    String? token}) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/ecmstep5_insert";
  final response = await http.post(Uri.parse(url), headers: {
    "Accept": "Application/json",
    'Authorization': 'Bearer $token',
  }, body: {
    'ecmitem_id': ecmItemId,
    'messagerepairing': repairMessage,
    'noterepairing': note,
    'startrepairing': start,
    'endrepairing': end,
    'user_id': userId,
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
