class StepEnamModel {
  String? checkH;
  String? checkM;
  String? repairH;
  String? repairM;
  String? hasilRepairH;
  String? hasilRepairM;
  String? mP;

  StepEnamModel(
      {this.checkH,
      this.checkM,
      this.repairH,
      this.repairM,
      this.hasilRepairH,
      this.hasilRepairM,
      this.mP});

  factory StepEnamModel.fromJson(Map<String, dynamic> json) {
    return StepEnamModel(
        checkH: json['check_h'].toString(),
        checkM: json['check_m'].toString(),
        repairH: json['repair_h'].toString(),
        repairM: json['repair_m'].toString(),
        hasilRepairH: json['hasil_checkrepair_h'].toString(),
        hasilRepairM: json['hasil_checkrepair_m'].toString(),
        mP: json['m/p'].toString());
  }

  Map<String, dynamic> toJson() => {
        'checkH': checkH,
        'checkM': checkM,
        'repairH': repairH,
        'garis_kuning_1': repairM,
        'garis_kuning_2': hasilRepairH,
        'garis_kuning_3': hasilRepairM,
        'garis_kuning_4': mP
      };
}
