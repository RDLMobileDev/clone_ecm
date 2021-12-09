// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/home/model/machinenamemodel.dart';
import 'package:http/http.dart' as http;

class MachineNameService {
  Future<List<MachineNameModel>> getMachineName(
      String idLocation, String token) async {
    List<MachineNameModel> _listMachineNameData = [];
    var url = MyUrl().getUrlDevice();

    try {
      final response = await http
          .get(Uri.parse("$url/get_machine?location_id=$idLocation"), headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      });

      var dataMachineName = json.decode(response.body)['data'];

      for (int i = 0; i < dataMachineName.length; i++) {
        var data = MachineNameModel(
            dataMachineName[i]['m_machine_kode'],
            dataMachineName[i]['m_machine_nama'],
            dataMachineName[i]["m_machine_id"].toString());

        _listMachineNameData.add(data);
      }

      return _listMachineNameData;
    } on SocketException catch (e) {
      print(e);
      return _listMachineNameData;
    } on TimeoutException catch (e) {
      print(e);
      return _listMachineNameData;
    } catch (e) {
      print(e);
      return _listMachineNameData;
    }
  }
}

final machineNameService = MachineNameService();
