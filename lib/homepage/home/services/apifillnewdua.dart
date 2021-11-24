// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:io';
import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future fillNewDua(
    String token,
    String shiftA,
    String shiftB,
    String shiftNs,
    String time,
    String problem,
    String safety,
    String delivery,
    String quality,
    String cost,
    String molding,
    String production,
    String other,
    String utility,
    String engineering,
    File foto1,
    File foto2,
    File foto3,
    File foto4,
    String ecmId,
    {required http.MultipartRequest request}) async {
  String myUrl = MyUrl().getUrlDevice() + "/ecm_step2";
  // String url = "$myUrl/siswa/izin";
  var uri = Uri.parse(myUrl);

  // ignore: prefer_conditional_assignment
  if (request == null) {
    request = http.MultipartRequest("POST", uri)
      ..headers["Accept"] = "Application/json"
      ..headers["Authorization"] = "Bearer $token"
      ..fields['shitfa'] = shiftA
      ..fields['shiftb'] = shiftB
      ..fields['shiftns'] = shiftNs
      ..fields['time'] = time
      ..fields['problem'] = problem
      ..fields['safety'] = safety
      ..fields['delivery'] = delivery
      ..fields['ecm_id'] = ecmId;
  }

  List<File> _listFoto = [foto1, foto2, foto3, foto4];

  for (int i = 1; i <= _listFoto.length + 1; i++) {
    var multipartFile =
        await http.MultipartFile.fromPath('foto$i', _listFoto[i].path);
    request.files.add(multipartFile);
  }

  // var response = await request.send();

  http.Response response = await http.Response.fromStream(await request.send());
  print("Result: ${response.statusCode}");

  if (response.statusCode == 200) {
    var convertDatatoJson = jsonDecode(response.body);
    print(convertDatatoJson);
    return convertDatatoJson;
  } else {
    return "error";
  }
}
