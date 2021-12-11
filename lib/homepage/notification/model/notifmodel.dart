// To parse this JSON data, do
//
//     final responApproved = responApprovedFromJson(jsonString);

import 'dart:convert';

ResponApproved responApprovedFromJson(String str) =>
    ResponApproved.fromJson(json.decode(str));

String responApprovedToJson(ResponApproved data) => json.encode(data.toJson());

class ResponApproved {
  ResponApproved({
    required this.response,
    required this.data,
  });

  Response response;
  List<Datum> data;

  factory ResponApproved.fromJson(Map<String, dynamic> json) => ResponApproved(
        response: Response.fromJson(json["response"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.notifecmId,
    required this.nama,
    required this.foto,
    required this.status,
  });

  int notifecmId;
  String nama;
  String foto;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        notifecmId: json["notifecm_id"],
        nama: json["nama"],
        foto: json["foto"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "notifecm_id": notifecmId,
        "nama": nama,
        "foto": foto,
        "status": status == null ? null : status,
      };
}

class Response {
  Response({
    required this.status,
    required this.message,
  });

  int status;
  String message;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
