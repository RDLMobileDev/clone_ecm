// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/home/model/machinenumbermodel.dart';
import 'package:http/http.dart' as http;

class MachineNumberService {
  Future<List<MachineNumberModel>> getMachineNumber(
      String idMachine, String token) async {
    List<MachineNumberModel> _listMachineNumberData = [];
    var url = MyUrl().getUrlDevice();

    try {
      final response = await http
          .get(Uri.parse("$url/get_machine?location_id=$idMachine"), headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      });

      return _listMachineNumberData;
    } on SocketException catch (e) {
      print(e);
      return _listMachineNumberData;
    } on TimeoutException catch (e) {
      print(e);
      return _listMachineNumberData;
    } catch (e) {
      print(e);
      return _listMachineNumberData;
    }
  }
}
