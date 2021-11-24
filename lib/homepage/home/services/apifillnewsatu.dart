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
    // var teamMemberJson = json.encode(teamMember);
    // print(token);
    print(classificationId);
    print(date);
    print(userId);
    print(teamMember);
    print(locationId);
    print(machineId);
    print(machineDetailId);
    String url = MyUrl().getUrlDevice();

    final removedBrackets =
        teamMember.toString().substring(1, teamMember.toString().length - 1);
    final parts = removedBrackets.split(', ');

    var joinedTeamMembar = parts.map((part) => "'$part'").join(', ');

    print(joinedTeamMembar);

    final response = await http.post(Uri.parse("$url/ecm_step1"), headers: {
      "Accept": "Application/json",
      'Authorization': 'Bearer $token',
    }, body: {
      'classification_id': classificationId,
      'date': date,
      'user_id': userId,
      'user_nama[]': joinedTeamMembar,
      'location_id': locationId,
      'machine_id': machineId,
      'machinedetail_id': machineDetailId
    });

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
