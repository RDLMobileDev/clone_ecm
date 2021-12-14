class HistoryAll {
  String? tEcmId;
  String? nama;
  String? foto;
  String? waktu;

  HistoryAll({this.tEcmId, this.nama, this.foto, this.waktu});

  factory HistoryAll.fromJson(Map<String, dynamic> json) {
    return HistoryAll(
        tEcmId: json['t_ecm_id'].toString(),
        nama: json['name'].toString(),
        foto: json['photo'].toString(),
        waktu: json['ago'].toString());
  }

  Map<String, dynamic> toJson() =>
      {'t_ecm_id': tEcmId, 'name': nama, 'photo ': foto, 'ago': waktu};
}
