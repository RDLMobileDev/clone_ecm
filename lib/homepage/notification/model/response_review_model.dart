// To parse this JSON data, do
//
//     final responReview = responReviewFromJson(jsonString);

import 'dart:convert';

ResponReview responReviewFromJson(String str) =>
    ResponReview.fromJson(json.decode(str));

String responReviewToJson(ResponReview data) => json.encode(data.toJson());

class ResponReview {
  ResponReview({
    required this.response,
    required this.data,
  });

  Response response;
  Data data;

  factory ResponReview.fromJson(Map<String, dynamic> json) => ResponReview(
        response: Response.fromJson(json["response"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.foto,
    required this.nama,
    required this.lokasi,
    required this.tanggal,
    required this.machineNama,
    required this.nomormesin,
    required this.teamMember,
    required this.incidentShift,
    required this.incidentJam,
    required this.incidentEffect,
    required this.incidentMistake,
    required this.incidentFoto1,
    required this.incidentFoto2,
    required this.incidentFoto3,
    required this.incidentFoto4,
    required this.incidentProblem,
    required this.analisisWhy1,
    required this.analisisWhy2,
    required this.analisisWhy3,
    required this.analisisWhy4,
    required this.analisisHow,
    required this.itemCheck,
    required this.itemRepair,
    required this.kaizenIdea,
    required this.kaizenCheckH,
    required this.kaizenCheckM,
    required this.kaizenRepairH,
    required this.kaizenRepairM,
    required this.kaizenTotalH,
    required this.kaizenTotalM,
    required this.kaizenBreaktimeH,
    required this.kaizenLinestarH,
    required this.kaizenLinestarM,
    required this.kaizenLinestopH,
    required this.kaizenLinestopM,
    required this.kaizenTotallinestopH,
    required this.kaizenTotallinestopM,
    required this.kaizenCosthouse,
    required this.kaizenOutcosthouse,
    required this.sparepart,
    required this.esign,
    required this.totalCost,
  });

  String foto;
  String nama;
  String lokasi;
  String tanggal;
  String machineNama;
  String nomormesin;
  List<TeamMember> teamMember;
  String incidentShift;
  String incidentJam;
  IncidentEffect incidentEffect;
  IncidentMistake incidentMistake;
  String incidentFoto1;
  String incidentFoto2;
  String incidentFoto3;
  String incidentFoto4;
  String incidentProblem;
  String analisisWhy1;
  String analisisWhy2;
  String analisisWhy3;
  String analisisWhy4;
  String analisisHow;
  List<ItemCheck> itemCheck;
  List<ItemRepair> itemRepair;
  String kaizenIdea;
  String kaizenCheckH;
  String kaizenCheckM;
  String kaizenRepairH;
  String kaizenRepairM;
  String kaizenTotalH;
  String kaizenTotalM;
  int kaizenBreaktimeH;
  String kaizenLinestarH;
  String kaizenLinestarM;
  String kaizenLinestopH;
  String kaizenLinestopM;
  String kaizenTotallinestopH;
  String kaizenTotallinestopM;
  String kaizenCosthouse;
  String kaizenOutcosthouse;
  List<Sparepart> sparepart;
  List<Esign> esign;
  String totalCost;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        foto: json["foto"],
        nama: json["nama"],
        lokasi: json["lokasi"],
        tanggal: json["tanggal"],
        machineNama: json["machine_nama"],
        nomormesin: json["nomormesin"],
        teamMember: List<TeamMember>.from(
            json["team_member"].map((x) => TeamMember.fromJson(x))),
        incidentShift: json["incident_shift"],
        incidentJam: json["incident_jam"],
        incidentEffect: IncidentEffect.fromJson(json["incident_effect"]),
        incidentMistake: IncidentMistake.fromJson(json["incident_mistake"]),
        incidentFoto1: json["incident_foto1"],
        incidentFoto2: json["incident_foto2"],
        incidentFoto3: json["incident_foto3"],
        incidentFoto4: json["incident_foto4"],
        incidentProblem: json["incident_problem"],
        analisisWhy1: json["analisis_why1"],
        analisisWhy2: json["analisis_why2"],
        analisisWhy3: json["analisis_why3"],
        analisisWhy4: json["analisis_why4"],
        analisisHow: json["analisis_how"],
        itemCheck: List<ItemCheck>.from(
            json["item_check"].map((x) => ItemCheck.fromJson(x))),
        itemRepair: List<ItemRepair>.from(
            json["item_repair"].map((x) => ItemRepair.fromJson(x))),
        kaizenIdea: json["kaizen_idea"],
        kaizenCheckH: json["kaizen_check_h"],
        kaizenCheckM: json["kaizen_check_m"],
        kaizenRepairH: json["kaizen_repair_h"],
        kaizenRepairM: json["kaizen_repair_m"],
        kaizenTotalH: json["kaizen_total_h"],
        kaizenTotalM: json["kaizen_total_m"],
        kaizenBreaktimeH: json["kaizen_breaktime_h"],
        kaizenLinestarH: json["kaizen_linestar_h"],
        kaizenLinestarM: json["kaizen_linestar_m"],
        kaizenLinestopH: json["kaizen_linestop_h"],
        kaizenLinestopM: json["kaizen_linestop_m"],
        kaizenTotallinestopH: json["kaizen_totallinestop_h"],
        kaizenTotallinestopM: json["kaizen_totallinestop_m"],
        kaizenCosthouse: json["kaizen_costhouse"],
        kaizenOutcosthouse: json["kaizen_outcosthouse"],
        sparepart: List<Sparepart>.from(
            json["sparepart"].map((x) => Sparepart.fromJson(x))),
        esign: List<Esign>.from(json["esign"].map((x) => Esign.fromJson(x))),
        totalCost: json["total_cost"],
      );

  Map<String, dynamic> toJson() => {
        "foto": foto,
        "nama": nama,
        "lokasi": lokasi,
        "tanggal": tanggal,
        "machine_nama": machineNama,
        "nomormesin": nomormesin,
        "team_member": List<dynamic>.from(teamMember.map((x) => x.toJson())),
        "incident_shift": incidentShift,
        "incident_jam": incidentJam,
        "incident_effect": incidentEffect.toJson(),
        "incident_mistake": incidentMistake.toJson(),
        "incident_foto1": incidentFoto1,
        "incident_foto2": incidentFoto2,
        "incident_foto3": incidentFoto3,
        "incident_foto4": incidentFoto4,
        "incident_problem": incidentProblem,
        "analisis_why1": analisisWhy1,
        "analisis_why2": analisisWhy2,
        "analisis_why3": analisisWhy3,
        "analisis_why4": analisisWhy4,
        "analisis_how": analisisHow,
        "item_check": List<dynamic>.from(itemCheck.map((x) => x.toJson())),
        "item_repair": List<dynamic>.from(itemRepair.map((x) => x.toJson())),
        "kaizen_idea": kaizenIdea,
        "kaizen_check_h": kaizenCheckH,
        "kaizen_check_m": kaizenCheckM,
        "kaizen_repair_h": kaizenRepairH,
        "kaizen_repair_m": kaizenRepairM,
        "kaizen_total_h": kaizenTotalH,
        "kaizen_total_m": kaizenTotalM,
        "kaizen_breaktime_h": kaizenBreaktimeH,
        "kaizen_linestar_h": kaizenLinestarH,
        "kaizen_linestar_m": kaizenLinestarM,
        "kaizen_linestop_h": kaizenLinestopH,
        "kaizen_linestop_m": kaizenLinestopM,
        "kaizen_totallinestop_h": kaizenTotallinestopH,
        "kaizen_totallinestop_m": kaizenTotallinestopM,
        "kaizen_costhouse": kaizenCosthouse,
        "kaizen_outcosthouse": kaizenOutcosthouse,
        "sparepart": List<dynamic>.from(sparepart.map((x) => x.toJson())),
        "esign": List<dynamic>.from(esign.map((x) => x.toJson())),
        "total_cost": totalCost,
      };
}

class Esign {
  Esign({
    required this.no,
    required this.nama,
    required this.jabatan,
    required this.status,
  });

  int no;
  String nama;
  String jabatan;
  String status;

  factory Esign.fromJson(Map<String, dynamic> json) => Esign(
        no: json["no"],
        nama: json["nama"],
        jabatan: json["jabatan"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "nama": nama,
        "jabatan": jabatan,
        "status": status == null ? null : status,
      };
}

class IncidentEffect {
  IncidentEffect({
    required this.tEcmSafety,
    required this.tEcmDelivery,
    required this.tEcmQuality,
    required this.tEcmCost,
  });

  int tEcmSafety;
  int tEcmDelivery;
  int tEcmQuality;
  int tEcmCost;

  factory IncidentEffect.fromJson(Map<String, dynamic> json) => IncidentEffect(
        tEcmSafety: json["t_ecm_safety"],
        tEcmDelivery: json["t_ecm_delivery"],
        tEcmQuality: json["t_ecm_quality"],
        tEcmCost: json["t_ecm_cost"],
      );

  Map<String, dynamic> toJson() => {
        "t_ecm_safety": tEcmSafety,
        "t_ecm_delivery": tEcmDelivery,
        "t_ecm_quality": tEcmQuality,
        "t_ecm_cost": tEcmCost,
      };
}

class IncidentMistake {
  IncidentMistake({
    required this.tEcmMolding,
    required this.tEcmProduction,
    required this.tEcmOther,
    required this.tEcmUtility,
    required this.tEcmEngineering,
  });

  int tEcmMolding;
  int tEcmProduction;
  int tEcmOther;
  int tEcmUtility;
  int tEcmEngineering;

  factory IncidentMistake.fromJson(Map<String, dynamic> json) =>
      IncidentMistake(
        tEcmMolding: json["t_ecm_molding"],
        tEcmProduction: json["t_ecm_production"],
        tEcmOther: json["t_ecm_other"],
        tEcmUtility: json["t_ecm_utility"],
        tEcmEngineering: json["t_ecm_engineering"],
      );

  Map<String, dynamic> toJson() => {
        "t_ecm_molding": tEcmMolding,
        "t_ecm_production": tEcmProduction,
        "t_ecm_other": tEcmOther,
        "t_ecm_utility": tEcmUtility,
        "t_ecm_engineering": tEcmEngineering,
      };
}

class ItemCheck {
  ItemCheck({
    required this.no,
    required this.namaPart,
    required this.namaStandar,
    required this.actual,
    required this.time,
    required this.note,
  });

  int no;
  String namaPart;
  String namaStandar;
  String actual;
  String time;
  dynamic note;

  factory ItemCheck.fromJson(Map<String, dynamic> json) => ItemCheck(
        no: json["no"],
        namaPart: json["nama_part"],
        namaStandar: json["nama_standar"],
        actual: json["actual"],
        time: json["time"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "nama_part": namaPart,
        "nama_standar": namaStandar,
        "actual": actual,
        "time": time,
        "note": note,
      };
}

class ItemRepair {
  ItemRepair({
    required this.no,
    required this.namaPart,
    required this.time,
    required this.repairing,
    required this.note,
  });

  int no;
  String namaPart;
  String time;
  String repairing;
  String note;

  factory ItemRepair.fromJson(Map<String, dynamic> json) => ItemRepair(
        no: json["no"],
        namaPart: json["nama_part"],
        time: json["time"],
        repairing: json["repairing"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "nama_part": namaPart,
        "time": time,
        "repairing": repairing,
        "note": note,
      };
}

class Sparepart {
  Sparepart({
    required this.no,
    required this.namaPart,
    required this.qty,
    required this.total,
    required this.totalHarga,
  });

  int no;
  String namaPart;
  String qty;
  String total;
  int totalHarga;

  factory Sparepart.fromJson(Map<String, dynamic> json) => Sparepart(
        no: json["no"],
        namaPart: json["nama_part"],
        qty: json["qty"],
        total: json["total"],
        totalHarga: json["total_harga"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "nama_part": namaPart,
        "qty": qty,
        "total": total,
        "total_harga": totalHarga,
      };
}

class TeamMember {
  TeamMember({
    required this.nama,
  });

  String nama;

  factory TeamMember.fromJson(Map<String, dynamic> json) => TeamMember(
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
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
