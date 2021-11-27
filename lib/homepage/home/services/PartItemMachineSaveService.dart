// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/home/model/partitemmachinesavedmodel.dart';

class PartItemMachineSaveService {
  Future<List<PartItemMachineSavedModel>> getPartItemMachineSaveData(
      String token, String ecmId) async {
    List<PartItemMachineSavedModel> _listDataPartMachineSaved = [];
    var url = MyUrl().getUrlDevice();
    try {
      final response = await http
          .get(Uri.parse("$url/ecm_step7_get?ecm_id=$ecmId"), headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      });

      var dataPartSaved = json.decode(response.body)['data'];

      for (int i = 0; i < dataPartSaved.length; i++) {
        var data = PartItemMachineSavedModel(
          dataPartSaved[i]['ecmpart_id'].toString(),
          dataPartSaved[i]['ecm_id'].toString(),
          dataPartSaved[i]['partitem_id'].toString(),
          dataPartSaved[i]['ecmpart_qty'].toString(),
          dataPartSaved[i]['ecmpart_harga'].toString(),
          dataPartSaved[i]['total_harga'].toString(),
        );
        _listDataPartMachineSaved.add(data);
      }

      return _listDataPartMachineSaved;
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

  Future deletePartMachineSaved(String idPart, String token) async {
    var url = MyUrl().getUrlDevice();
    try {
      final response =
          await http.post(Uri.parse("$url/ecm_step7_delete"), headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      }, body: {
        'ecmpart_id': idPart
      });

      return json.decode(response.body);
    } on SocketException catch (e) {
      print(e);
    } on TimeoutException catch (e) {
      print(e);
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}

final partItemMachineSaveService = PartItemMachineSaveService();
