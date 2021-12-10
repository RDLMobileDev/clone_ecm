import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:e_cm/baseurl/baseurl.dart';

Future saveDataPartMachine(
  String token,
  String ecmId,
  String idMesin,
  String partName,
  String stock,
  String ecmqty,
  String harga,
) async {
  String url = MyUrl().getUrlDevice();

  try {
    final response =
        await http.post(Uri.parse("$url/ecm_step7_insert"), headers: {
      "Accept": "Application/json",
      'Authorization': 'Bearer $token',
    }, body: {
      'ecm_id': ecmId,
      'id_machine': idMesin,
      'part_name': partName,
      'stock': stock,
      'ecmpart_qty': ecmqty,
      'ecmpart_harga': harga,
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
