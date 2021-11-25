// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;

Future fillNewSatu(
  String token,
  String classificationId,
  String date,
  String userId,
  List<String> teamMember,
  String locationId,
  String machineId,
  String machineDetailId,
) async {
  try {
    print(token);
    print(classificationId);
    print(date);
    print(userId);
    print(teamMember);
    print(locationId);
    print(machineId);
    print(machineDetailId);

    Map<String, String> data;
    
    data = {
      'classification_id': classificationId,
      'date': date,
      'user_id': userId,
      'location_id': locationId,
      'machine_id': machineId,
      'machinedetail_id': machineDetailId
    };

    for(int i = 0; i < teamMember.length; i++){
      data.addAll({"user_nama[$i]": teamMember[i]});
    }

    String url = MyUrl().getUrlDevice();
    final response = await http.post(Uri.parse("$url/ecm_step1"), headers: {
      "Accept": "Application/json",
      'Authorization': 'Bearer $token',
    }, body: data);

    if (response.body.isNotEmpty) {
      var convertDatatoJson = jsonDecode(response.body);
      json.decode(response.body);
      return convertDatatoJson;
    }
  } on SocketException catch (e) {
    print(e);
  } on TimeoutException catch (e) {
    print(e);
  } catch (e) {
    print(e);
  }
}