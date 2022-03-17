// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

// File foto1,
// File foto2,
// File foto3,
// File foto4,

String myUrl = MyUrl().getUrlDevice();

Future fillNewDua({
  required String token,
  required String shiftA,
  required String shiftB,
  required String shiftNs,
  required String time,
  required String problem,
  required String safety,
  required String delivery,
  required String quality,
  required String cost,
  required String molding,
  required String production,
  required String other,
  required String utility,
  required String engineering,
  // required List<XFile> images,
  // required List<String>? imagesName,
  required List<String>? imagesPath,
  required String ecmId,
}) async {
  String url = myUrl + "/ecm_step2";
  // String url = "$myUrl/siswa/izin";
  var uri = Uri.parse(url);

  http.MultipartRequest request = http.MultipartRequest("POST", uri);
  print("list images: ${imagesPath!.length.toString()}");

  int indexImage = 1;
  for (int i = 0; i < imagesPath.length; i++) {
    print(imagesPath[i]);
    request.files.add(
        await http.MultipartFile.fromPath('foto$indexImage', imagesPath[i]));
    indexImage++;
  }

  print("from: $ecmId");

  request.headers["Accept"] = "Application/json";
  request.headers["Authorization"] = "Bearer $token";

  request.fields['shifta'] = shiftA;
  request.fields['shiftb'] = shiftB;
  request.fields['shiftns'] = shiftNs;
  request.fields['time'] = time;
  request.fields['problem'] = problem;
  request.fields['safety'] = safety;
  request.fields['delivery'] = delivery;
  request.fields['quality'] = quality;
  request.fields['cost'] = cost;
  request.fields['molding'] = molding;
  request.fields['production'] = production;
  request.fields['other'] = other;
  request.fields['utility'] = utility;
  request.fields['engineering'] = engineering;
  request.fields['ecm_id'] = ecmId;

  // print("from field: ${request.fields['id_ecm']}");

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

Future getStepDuaDataForEdit(String idEcm, String token) async {
  try {
    final response = await http
        .get(Uri.parse("$myUrl/ecm_step2_get?ecm_id=$idEcm"), headers: {
      "Accept": "Application/json",
      'Authorization': 'Bearer $token',
    });

    return jsonDecode(response.body);
  } catch (e) {
    print(e);
  }
}
