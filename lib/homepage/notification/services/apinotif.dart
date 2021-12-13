import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/notification/model/notifmodel.dart';
import 'package:http/http.dart' as http;

class NotifikasiService {
  Future<List<NotificationModel>> getNotificationData(
      String token, String idUser) async {
    List<NotificationModel> _listNotificationData = [];

    String url = MyUrl().getUrlDevice();

    try {
      final response = await http
          .get(Uri.parse("$url/notif_review?user_id=$idUser"), headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      });

      var dataNotif = json.decode(response.body);

      for (int i = 0; i < dataNotif['data'].length; i++) {
        var dataModel = NotificationModel(
            dataNotif['data'][i]['id'].toString(),
            dataNotif['data'][i]['nama'].toString(),
            dataNotif['data'][i]['photo'].toString(),
            dataNotif['data'][i]['waktu'].toString());

        _listNotificationData.add(dataModel);
      }

      return _listNotificationData;
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

final notifikasiService = NotifikasiService();
