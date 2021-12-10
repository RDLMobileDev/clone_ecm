class ItemChecking {
  int? ecmitemId;
  int? ecmId;
  String? partNama;
  int? waktuJam;
  int? waktuMenit;

  ItemChecking(
      {this.ecmitemId,
      this.ecmId,
      this.partNama,
      this.waktuJam,
      this.waktuMenit});

  ItemChecking.fromJson(Map<String, dynamic> json) {
    ecmitemId = json['ecmitem_id'];
    ecmId = json['ecm_id'];
    partNama = json['part_nama'];
    waktuJam = json['waktu_jam'];
    waktuMenit = json['waktu_menit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ecmitem_id'] = this.ecmitemId;
    data['ecm_id'] = this.ecmId;
    data['part_nama'] = this.partNama;
    data['waktu_jam'] = this.waktuJam;
    data['waktu_menit'] = this.waktuMenit;
    return data;
  }
}
