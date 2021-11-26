// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


    // File foto1,
    // File foto2,
    // File foto3,
    // File foto4,

Future fillNewDua(
    {String? token,
    String? shiftA,
    String? shiftB,
    String? shiftNs,
    String? time,
    String? problem,
    String? safety,
    String? delivery,
    String? quality,
    String? cost,
    String? molding,
    String? production,
    String? other,
    String? utility,
    String? engineering,
    List<String>? imagesName,
    List<String>? imagesPath,
    String? ecmId,}) async {
  String myUrl = MyUrl().getUrlDevice() + "/ecm_step2";
  // String url = "$myUrl/siswa/izin";
  var uri = Uri.parse(myUrl);

  http.MultipartRequest request = http.MultipartRequest("POST", uri);

  int index = 1;
  for(int i = 0; i < imagesName!.length; i++){
    request.files.add(http.MultipartFile.fromBytes("foto$index", await File.fromUri(Uri.parse(imagesPath![i])).readAsBytes()));
    index++;
  }

  print("from: $ecmId");

  request.headers["Accept"] = "Application/json";
  request.headers["Authorization"] = "Bearer $token";

  request.fields['shifta'] = shiftA!;
  request.fields['shiftb'] = shiftB!;
  request.fields['shiftns'] = shiftNs!;
  request.fields['time'] = time!;
  request.fields['problem'] = problem!;
  request.fields['safety'] = safety!;
  request.fields['delivery'] = delivery!;
  request.fields['quality'] = quality!;
  request.fields['cost'] = cost!;
  request.fields['molding'] = molding!;
  request.fields['production'] = production!;
  request.fields['other'] = other!;
  request.fields['utility'] = utility!;
  request.fields['engineering'] = engineering!;
  request.fields['ecm_id'] = ecmId!;

  http.Response response = await http.Response.fromStream(await request.send());
  print("Result: ${response.statusCode}");

  if (response.statusCode == 200) {
    var convertDatatoJson = jsonDecode(response.body);
    // print(convertDatatoJson);
    return convertDatatoJson;
  } else {
    return "error";
  }
}
