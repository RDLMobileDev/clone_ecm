import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/home/model/membername.dart';
import 'package:http/http.dart' as http;

Future<List<MemberNameModel>> getDataMemberName(String token) async {
  List<MemberNameModel> _listDataMember = [];

  String myUrl = MyUrl().getUrlDevice();
  Uri url = Uri.parse("$myUrl/get_usersemua");

  try {
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    var dataMember = json.decode(response.body)['data'];

    for (int i = 0; i < dataMember.length; i++) {
      var dataModel = MemberNameModel(
          dataMember[i]['id'].toString(), dataMember[i]['fullname']);

      _listDataMember.add(dataModel);
    }

    return _listDataMember;
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
