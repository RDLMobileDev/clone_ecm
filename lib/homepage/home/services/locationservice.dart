import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/home/model/locationmodel.dart';
import 'package:http/http.dart' as http;

class LocationService {
  Future<List<LocationModel>> getLocationData(String token) async {
    List<LocationModel> _listLocationData = [];
    var url = MyUrl().getUrlDevice();

    try {
      final response = await http.get(Uri.parse("$url/get_location"), headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      });

      var dataLocation = json.decode(response.body)['data'];

      for (int i = 0; i < dataLocation.length; i++) {
        var data = LocationModel(dataLocation[i]['m_location_id'].toString(),
            dataLocation[i]['m_location_nama']);
        _listLocationData.add(data);
      }

      return _listLocationData;
    } on SocketException catch (e) {
      print(e);
      return _listLocationData;
    } on TimeoutException catch (e) {
      print(e);
      return _listLocationData;
    } catch (e) {
      print(e);
      return _listLocationData;
    }
  }
}

final locationService = LocationService();
