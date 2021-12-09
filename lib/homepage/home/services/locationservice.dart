import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/home/model/groupareamodel.dart';
import 'package:e_cm/homepage/home/model/locationmodel.dart';
import 'package:http/http.dart' as http;

class LocationService {
  Future<List<LocationModel>> getLocationData(String token) async {
    List<LocationModel> _listLocationData = [];
    var url = MyUrl().getUrlDevice();

    try {
      final response = await http.get(Uri.parse("$url/get_factory"), headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      });

      var dataLocation = json.decode(response.body)['data'];

      print("location data:");
      print(json.decode(response.body));

      for (int i = 0; i < dataLocation.length; i++) {
        var data = LocationModel(
          dataLocation[i]['enum_id'].toString(),
          dataLocation[i]['key'].toString(),
          dataLocation[i]['value'].toString(),
          dataLocation[i]['category'].toString(),
        );
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

  Future<List<GroupAreaModel>> getAreaGroupList(String token) async {
    List<GroupAreaModel> _listAreaGroup = [];
    var url = MyUrl().getUrlDevice();

    try {
      final response = await http.get(Uri.parse("$url/get_factorygroup"), headers: {
        "Accept": "Application/json",
        'Authorization': 'Bearer $token',
      });

      var dataLocationGroup = json.decode(response.body)['data'];

      print("location group data:");
      print(json.decode(response.body));

      for (int i = 0; i < dataLocationGroup.length; i++) {
        var dataGroupArea = GroupAreaModel(
          dataLocationGroup[i]['enum_id'].toString(),
          dataLocationGroup[i]['key'].toString(),
          dataLocationGroup[i]['value'].toString(),
          dataLocationGroup[i]['category'].toString(),
        );
        _listAreaGroup.add(dataGroupArea);
      }

      return _listAreaGroup;
    } on SocketException catch (e) {
      print(e);
      return _listAreaGroup;
    } on TimeoutException catch (e) {
      print(e);
      return _listAreaGroup;
    } catch (e) {
      print(e);
      return _listAreaGroup;
    }
  }
}

final locationService = LocationService();
