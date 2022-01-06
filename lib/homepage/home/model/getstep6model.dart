class StepEnamModel {
  String? checkH;
  String? checkM;
  String? repairH;
  String? repairM;
  String? hasilRepairH;
  String? hasilRepairM;
  String? mP;
  String? outHouseRp;

  StepEnamModel(
      {this.checkH,
      this.checkM,
      this.repairH,
      this.repairM,
      this.hasilRepairH,
      this.hasilRepairM,
      this.mP,
      this.outHouseRp});

  factory StepEnamModel.fromJson(Map<String, dynamic> json) {
    return StepEnamModel(
        checkH: json['check_h'].toString(),
        checkM: json['check_m'].toString(),
        repairH: json['repair_h'].toString(),
        repairM: json['repair_m'].toString(),
        hasilRepairH: json['hasil_checkrepair_h'].toString(),
        hasilRepairM: json['hasil_checkrepair_m'].toString(),
        mP: json['m/p'].toString(),
        outHouseRp: json['outhouse'].toString());
  }

  Map<String, dynamic> toJson() => {
        'check_h'.toString(): checkH,
        'check_m'.toString(): checkM,
        'repair_h'.toString(): repairH,
        'repair_m'.toString(): repairM,
        'hasil_checkrepair_h'.toString(): hasilRepairH,
        'hasil_checkrepair_m'.toString(): hasilRepairM,
        'm/p'.toString(): mP
      };
}
