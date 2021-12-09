import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:e_cm/baseurl/baseurl.dart';

Future saveDataPartMachine(String token, String idEcm, String partId,
    String partQty, String partCost) async {
  String url = MyUrl().getUrlDevice();

  try {
    final response =
        await http.post(Uri.parse("$url/ecm_step7_insert"), headers: {
      "Accept": "Application/json",
      'Authorization': 'Bearer $token',
    }, body: {
      'ecm_id': idEcm,
      'partitem_id': partId,
      'ecmpart_qty': partQty,
      'ecmpart_harga': partCost,
    });

    return json.decode(response.body);
  } on SocketException catch (e) {
    print(e);
  } on TimeoutException catch (e) {
    print(e);
  } on Exception catch (e) {
    print(e);
  } catch (e) {
    print(e);
  }
}
