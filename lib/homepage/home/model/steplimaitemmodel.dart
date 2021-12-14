class StepLimaItemModel {
  String? partNama;
  String? note;
  String? tEcmitemStart;
  String? tEcmitemEnd;
  String? userName;
  String? userNameId;
  String? repairMade;

  StepLimaItemModel(
      {this.partNama,
      this.note,
      this.tEcmitemStart,
      this.tEcmitemEnd,
      this.userName,
      this.repairMade});

  StepLimaItemModel.fromJson(Map<String, dynamic> json) {
    partNama = json['part_nama'];
    note = json['note'];
    tEcmitemStart = json['t_ecmitem_start'];
    tEcmitemEnd = json['t_ecmitem_end'];
    userName = json['user_name'];
    userNameId = json['username_id'];
    repairMade = json['repair_made'];
  }
}
