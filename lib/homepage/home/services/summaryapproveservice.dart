import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/home/model/summaryapprovemodel.dart';

import 'package:http/http.dart' as http;

class SummaryApproveService {
  Future<List<SummaryApproveModel>> getSummaryApproveName(
      String token, String ecmId, String idUser) async {
    List<SummaryApproveModel> _listSummaryApproveName = [];

    var url = MyUrl().getUrlDevice();

    try {
      final response = await http.get(
          Uri.parse("$url/summary?ecm_id=$ecmId&user_id=$idUser"),
          headers: {
            "Accept": "Application/json",
            'Authorization': 'Bearer $token',
          });

      var dataApproval = json.decode(response.body);

      // print(dataApproval);

      for (int i = 0; i < dataApproval['data']['sumary'].length; i++) {
        var dataModel = SummaryApproveModel(
          dataApproval['data']['sumary'][i]['nama'].toString(),
          dataApproval['data']['sumary'][i]['photo'].toString(),
          dataApproval['data']['sumary'][i]['role'].toString(),
          dataApproval['data']['line_stop']['jam'].toString(),
          dataApproval['data']['line_stop']['menit'].toString(),
        );

        _listSummaryApproveName.add(dataModel);
      }

      return _listSummaryApproveName;
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
      print("from approve");
      print(e);
      return [];
    }
  }
}

final summaryApproveService = SummaryApproveService();
