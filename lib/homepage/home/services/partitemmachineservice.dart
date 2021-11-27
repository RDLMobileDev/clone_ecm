import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/home/model/partitemmachinemodel.dart';

class PartItemMachineService {
  Future<List<PartItemMachineModel>> getPartItemMachine(
      String token, String ecmId) async {
    List<PartItemMachineModel> _listDataPartItemMachine = [];

    var url = MyUrl().getUrlDevice();

    try {
      final response = await http
          .get(Uri.parse("$url/get_partitem?ecm_id=$ecmId"), headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      });

      var dataPart = json.decode(response.body)['data'];

      for (int i = 0; i < dataPart.length; i++) {
        var dataModel = PartItemMachineModel(
          dataPart[i]['m_partitem_id'].toString(),
          dataPart[i]['m_machine_id'].toString(),
          dataPart[i]['m_part_id'].toString(),
          dataPart[i]['m_part_nama'].toString(),
          dataPart[i]['m_part_standard'].toString(),
          dataPart[i]['m_part_stock'].toString(),
          dataPart[i]['m_part_harga'].toString(),
        );

        _listDataPartItemMachine.add(dataModel);
      }
      return _listDataPartItemMachine;
    } on SocketException catch (e) {
      print(e);
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
}

final partItemMachineService = PartItemMachineService();
