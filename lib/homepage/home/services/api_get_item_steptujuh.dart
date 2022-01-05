import 'dart:convert';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future getItemStepTujuh(String token, String ecmId) async {
  String myUrl = MyUrl().getUrlDevice();

  try {
    var response = await http
        .get(Uri.parse("$myUrl/get_partitem?ecm_id=$ecmId"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    var dataPartStepTujuh = json.decode(response.body);
    if (dataPartStepTujuh['response']['status'] == 200) {
      return dataPartStepTujuh['data'];
    }
  } on SocketException catch (e) {
    print(e);
  } on PlatformException catch (e) {
    print(e);
  } catch (e) {
    print(e);
  }
}
