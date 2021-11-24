// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/home/model/classificationmodel.dart';
import 'package:http/http.dart' as http;

class ClassificationService {
  Future<List<ClassificationModel>> getClassificationData() async {
    List<ClassificationModel> _listClassificationData = [];
    var url = MyUrl().getUrlDevice();

    try {
      final response = await http.get(Uri.parse("$url/get_classification"));
      var dataClassification = json.decode(response.body)['data'];

      for (int i = 0; i < dataClassification.length; i++) {
        var data = ClassificationModel(
            dataClassification[i]['m_classification_id'].toString(),
            dataClassification[i]['m_classification_nama']);

        _listClassificationData.add(data);
      }

      return _listClassificationData;
    } on SocketException catch (e) {
      print(e);
      return _listClassificationData;
    } on TimeoutException catch (e) {
      print(e);
      return _listClassificationData;
    } catch (e) {
      print(e);
      return _listClassificationData;
    }
  }
}

final classificationService = ClassificationService();
