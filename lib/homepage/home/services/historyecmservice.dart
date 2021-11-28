import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/home/model/historyecmmodel.dart';

class HistoryEcmService {
  Future<List<HistoryEcmModel>> getHistoryEcmModel(
      String userId, String token) async {
    List<HistoryEcmModel> _listHistoryEcmData = [];
    var url = MyUrl().getUrlDevice();

    try {
      final response =
          await http.get(Uri.parse("$url/history?user_id=$userId"), headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      });

      var dataHistory = json.decode(response.body);

      if (dataHistory['data'] != null) {
        for (int i = 0; i < dataHistory['data'].length; i++) {
          var dataModel = HistoryEcmModel(
              dataHistory['data'][i]['ecm_id'].toString(),
              dataHistory['data'][i]['date'],
              dataHistory['data'][i]['lokasi'],
              dataHistory['data'][i]['classification'],
              dataHistory['data'][i]['total_harga'],
              dataHistory['data'][i]['arrayitemrepair']);
          _listHistoryEcmData.add(dataModel);
        }

        return _listHistoryEcmData;
      } else {
        return [];
      }
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

final historyEcmService = HistoryEcmService();
