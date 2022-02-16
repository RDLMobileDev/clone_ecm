class DetailEcmModel {
  String? klasifikasi;
  String? foto;
  String? nama;
  String? lokasi;
  String? tanggal;
  String? mesinKode;
  String? machineNama;
  String? nomormesin;
  String? incidentShift;
  String? incidentJam;
  String? incidentEffect;
  String? incidentMistake;
  String? incidentFoto1;
  String? incidentFoto2;
  String? incidentFoto3;
  String? incidentFoto4;
  String? incidentProblem;
  String? analisisWhy1;
  String? analisisWhy2;
  String? analisisWhy3;
  String? analisisWhy4;
  String? analisisHow;
  String? kaizenIdea;
  String? kaizenCheckH;
  String? kaizenCheckM;
  String? kaizenRepairH;
  String? kaizenRepairM;
  String? kaizenTotalH;
  String? kaizenTotalM;
  String? kaizenBreaktimeH;
  String? kaizenLinestarH;
  String? kaizenLinestarM;
  String? kaizenLinestopH;
  String? kaizenLinestopM;
  String? kaizenTotallinestopH;
  String? kaizenTotallinestopM;
  String? kaizenCosthouse;
  String? kaizenOutcosthouse;
  String? totalCost;

  DetailEcmModel(
      {this.klasifikasi,
      this.foto,
      this.nama,
      this.lokasi,
      this.tanggal,
      this.mesinKode,
      this.machineNama,
      this.nomormesin,
      this.incidentShift,
      this.incidentJam,
      this.incidentEffect,
      this.incidentMistake,
      this.incidentFoto1,
      this.incidentFoto2,
      this.incidentFoto3,
      this.incidentFoto4,
      this.incidentProblem,
      this.analisisWhy1,
      this.analisisWhy2,
      this.analisisWhy3,
      this.analisisWhy4,
      this.analisisHow,
      this.kaizenIdea,
      this.kaizenCheckH,
      this.kaizenCheckM,
      this.kaizenRepairH,
      this.kaizenRepairM,
      this.kaizenTotalH,
      this.kaizenTotalM,
      this.kaizenBreaktimeH,
      this.kaizenLinestarH,
      this.kaizenLinestarM,
      this.kaizenLinestopH,
      this.kaizenLinestopM,
      this.kaizenTotallinestopH,
      this.kaizenTotallinestopM,
      this.kaizenCosthouse,
      this.kaizenOutcosthouse,
      this.totalCost});

  factory DetailEcmModel.fromJson(Map<String, dynamic> json) {
    return DetailEcmModel(
      klasifikasi: json['clasifikasi'].toString(),
      foto: json['foto'].toString(),
      nama: json['nama'].toString(),
      lokasi: json['lokasi'].toString(),
      tanggal: json['tanggal'].toString(),
      mesinKode: json['mesin_kode'].toString(),
      machineNama: json['machine_nama'].toString(),
      nomormesin: json['nomormesin'].toString(),
      incidentShift: json['incident_shift'].toString(),
      incidentJam: json['incident_jam'].toString(),
      incidentEffect: json['incident_effect'].toString(),
      incidentMistake: json['incident_mistake'].toString(),
      incidentFoto1: json['incident_foto1'].toString(),
      incidentFoto2: json['incident_foto2'].toString(),
      incidentFoto3: json['incident_foto3'].toString(),
      incidentFoto4: json['incident_foto4'].toString(),
      incidentProblem: json['incident_problem'].toString(),
      analisisWhy1: json['analisis_why1'].toString(),
      analisisWhy2: json['analisis_why2'].toString(),
      analisisWhy3: json['analisis_why3'].toString(),
      analisisWhy4: json['analisis_why4'].toString(),
      analisisHow: json['analisis_how'].toString(),
      kaizenIdea: json['kaizen_idea'].toString(),
      kaizenCheckH: json['kaizen_check_h'].toString(),
      kaizenCheckM: json['kaizen_check_m'].toString(),
      kaizenRepairH: json['kaizen_repair_h'].toString(),
      kaizenRepairM: json['kaizen_repair_m'].toString(),
      kaizenTotalH: json['kaizen_total_h'].toString(),
      kaizenTotalM: json['kaizen_total_m'].toString(),
      kaizenBreaktimeH: json['kaizen_breaktime_h'].toString(),
      kaizenLinestarH: json['kaizen_linestar_h'].toString(),
      kaizenLinestarM: json['kaizen_linestar_m'].toString(),
      kaizenLinestopH: json['kaizen_linestop_h'].toString(),
      kaizenLinestopM: json['kaizen_linestop_m'].toString(),
      kaizenTotallinestopH: json['kaizen_totallinestop_h'].toString(),
      kaizenTotallinestopM: json['kaizen_totallinestop_m'].toString(),
      kaizenCosthouse: json['kaizen_costhouse'].toString(),
      kaizenOutcosthouse: json['kaizen_outcosthouse'].toString(),
      totalCost: json['total_cost'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'clasifikasi': klasifikasi,
        'foto': foto,
        'nama': nama,
        'lokasi': lokasi,
        'tanggal': tanggal,
        'mesin_kode': mesinKode,
        'machine_nama': machineNama,
        'nomormesin': nomormesin,
        'incident_shift': incidentShift,
        'incident_jam': incidentJam,
        'incident_effect': incidentEffect,
        'incident_mistake': incidentMistake,
        'incident_foto1': incidentFoto1,
        'incident_foto2': incidentFoto2,
        'incident_foto3': incidentFoto3,
        'incident_foto4': incidentFoto4,
        'incident_problem': incidentProblem,
        'analisis_why1': analisisWhy1,
        'analisis_why2': analisisWhy2,
        'analisis_why3': analisisWhy3,
        'analisis_why4': analisisWhy4,
        'analisis_how': analisisHow,
        'kaizen_idea': kaizenIdea,
        'kaizen_check_h': kaizenCheckH,
        'kaizen_check_m': kaizenCheckM,
        'kaizen_repair_h': kaizenRepairH,
        'kaizen_repair_m': kaizenRepairM,
        'kaizen_total_h': kaizenTotalH,
        'kaizen_total_m': kaizenTotalM,
        'kaizen_breaktime_h': kaizenBreaktimeH,
        'kaizen_linestar_h': kaizenLinestarH,
        'kaizen_linestar_m': kaizenLinestarM,
        'kaizen_linestop_h': kaizenLinestopH,
        'kaizen_linestop_m': kaizenLinestopM,
        'kaizen_totallinestop_h': kaizenTotallinestopH,
        'kaizen_totallinestop_m': kaizenTotallinestopM,
        'kaizen_costhouse': kaizenCosthouse,
        'kaizen_outcosthouse': kaizenOutcosthouse,
        'total_cost': totalCost
      };
}
