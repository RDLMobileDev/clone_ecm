import 'dart:async';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future getHistoryMonthly(String token, tahun, bulan) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/history_semuabulan?year=$tahun&month=$bulan";

  try {
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
