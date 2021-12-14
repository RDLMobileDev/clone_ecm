import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;

Future hapusItemFillLima(String ecmItemId, String token) async {
  var url = MyUrl().getUrlDevice();
  try {
    var response = await http.post(Uri.parse("$url/ecmstep5_delete"), headers: {
      "Accept": "Application/json",
      'Authorization': 'Bearer $token',
    }, body: {
      'ecmitem_id': ecmItemId
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
