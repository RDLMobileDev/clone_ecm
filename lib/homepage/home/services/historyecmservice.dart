import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
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

      log("data history -> $dataHistory");

      if (dataHistory['data'] != null) {
        for (int i = 0; i < dataHistory['data'].length; i++) {
          var dataModel = HistoryEcmModel(
            dataHistory['data'][i]['ecm_id'].toString(),
            dataHistory['data'][i]['date'].toString(),
            dataHistory['data'][i]['lokasi'].toString(),
            dataHistory['data'][i]['classification'].toString(),
            dataHistory['data'][i]['total_harga'].toString(),
            dataHistory['data'][i]['arrayitemrepair'],
            dataHistory['data'][i]['nama_mesin'].toString(),
            dataHistory['data'][i]['no_mesin'].toString(),
            dataHistory['data'][i]['problem'].toString(),
          );
          _listHistoryEcmData.add(dataModel);
        }

        // sorting list result
        _listHistoryEcmData.sort(
          (a, b) {
            var previous = a.ecmId;
            var next = b.ecmId;
            return next.compareTo(previous);
          },
        );

        return _listHistoryEcmData;
      } else {
        return [];
      }
    } on SocketException catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: 'Gagal memuat riwayat, koneksi Anda terputus',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          fontSize: 16);
      return [];
    } on TimeoutException catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: 'Gagal memuat riwayat, waktu koneksi Anda habis',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          fontSize: 16);
      return [];
    } on Exception catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: ' history, terjadi kesalahan pada jaringan',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          fontSize: 16);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}

final historyEcmService = HistoryEcmService();
