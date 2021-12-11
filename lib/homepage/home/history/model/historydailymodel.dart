class HistoryDaily {
  String? tEcmId;
  String? nama;
  String? foto;
  String? waktu;

  HistoryDaily({this.tEcmId, this.nama, this.foto, this.waktu});

  factory HistoryDaily.fromJson(Map<String, dynamic> json) {
    return HistoryDaily(
        tEcmId: json['notifecm_id'].toString(),
        nama: json['name'].toString(),
        foto: json['photo'].toString(),
        waktu: json['ago'].toString());
  }

  Map<String, dynamic> toJson() =>
      {'notifecm_id': tEcmId, 'name': nama, 'photo ': foto, 'ago': waktu};
}
