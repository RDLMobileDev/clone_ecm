class ItemCheckingDetail {
  String? partNama;
  String? partStandard;
  String? actual;
  String? note;
  String? tEcmitemStart;
  String? tEcmitemEnd;
  String? userName;

  ItemCheckingDetail(
      {this.partNama,
      this.partStandard,
      this.actual,
      this.note,
      this.tEcmitemStart,
      this.tEcmitemEnd,
      this.userName});

  ItemCheckingDetail.fromJson(Map<String, dynamic> json) {
    partNama = json['part_nama'];
    partStandard = json['part_standard'];
    actual = json['actual'];
    note = json['note'];
    tEcmitemStart = json['t_ecmitem_start'];
    tEcmitemEnd = json['t_ecmitem_end'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['part_nama'] = this.partNama;
    data['part_standard'] = this.partStandard;
    data['actual'] = this.actual;
    data['note'] = this.note;
    data['t_ecmitem_start'] = this.tEcmitemStart;
    data['t_ecmitem_end'] = this.tEcmitemEnd;
    data['user_name'] = this.userName;
    return data;
  }
}
