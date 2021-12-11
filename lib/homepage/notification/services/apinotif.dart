import 'package:e_cm/homepage/notification/model/notifmodel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  String _url = 'http://app.ragdalion.com/ecm/public/api';

  Future<List<Datum>> getListApproved() async {
    List<Datum> listApproved = [];
    final response = await http.get(Uri.parse('$_url/get_notif'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ResponApproved respApproved = ResponApproved.fromJson(json);

      respApproved.data.forEach((item) {
        listApproved.add(item);
      });

      return listApproved;
    } else {
      return [];
    }
  }
}
