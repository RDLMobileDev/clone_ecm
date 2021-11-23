// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
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
      final response = await http.get(
          Uri.parse("$url/get_machinenumber?machine_id=$idMachine"),
          headers: {
            "Accept": "Application/json",
            'Authorization': 'Bearer $token',
          });

      var dataNumberMachine = json.decode(response.body)['data'];

      for (int i = 0; i < dataNumberMachine.length; i++) {
        var data = MachineNumberModel(
            dataNumberMachine[i]['m_machine_id'].toString(),
            dataNumberMachine[i]['m_machinedetail_nomesin']);

        _listMachineNumberData.add(data);
      }

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

final machineNumberService = MachineNumberService();
