import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future fillNewLimaInsert(
    String noteRepairing,
    String startRepairing,
    String endRepairing,
    String msgRepairing,
    String userId,
    String idEcm,
    String idMesin,
    String itemCheck,
    String idUser,
    String ecmItemId,
    String token) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/ecmstep5_insert";

  // final response = await http.post(Uri.parse(url), headers: {
  //   "Accept": "Application/json",
  //   'Authorization': 'Bearer $token',
  // }, body: {
  //   'ecmitem_id': ecmItemId,
  //   'messagerepairing': repairMessage,
  //   'noterepairing': note,
  //   'startrepairing': start,
  //   'endrepairing': end,
  //   'user_id': userId,
  //   'id_ecm': idEcm,
  //   'id_machine': idMesin
  // });

  final response = await http.post(Uri.parse(url), headers: {
    "Accept": "Application/json",
    'Authorization': 'Bearer $token',
  }, body: {
    'noterepairing': noteRepairing,
    'startrepairing': startRepairing,
    'endrepairing': endRepairing,
    'messagerepairing': msgRepairing,
    'user_id': userId,
    'id_ecm': idEcm,
    'id_machine': idMesin,
    'item_check': itemCheck,
    'id_user': idUser,
    'ecmitem_id': ecmItemId
  });

  if (response.body.isNotEmpty) {
    var convertDatatoJson = jsonDecode(response.body);
    json.decode(response.body);
    return convertDatatoJson;
  }
}
