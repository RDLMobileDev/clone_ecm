import 'dart:async';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future getUserAll(String token, String idUser) async {
  String myUrl = MyUrl().getUrlDevice();
  String url = "$myUrl/get_usersemua?id_user=$idUser";
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
    Fluttertoast.showToast(
        msg: 'Gagal memuat data user, periksa koneksi Anda',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        fontSize: 16);
    return [];
  } on TimeoutException catch (e) {
    print(e);
    return [];
  } on Exception catch (e) {
    print(e);
    return [];
  } catch (e) {
    print(e);
    return [];
  }
}
