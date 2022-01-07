class ApprovedModel {
  String? notifEcmId;
  String? nama;
  String? foto;
  String? status;
  String? waktu;

  ApprovedModel(
      {this.notifEcmId, this.nama, this.foto, this.status, this.waktu});

  factory ApprovedModel.fromJson(Map<String, dynamic> json) {
    return ApprovedModel(
        notifEcmId: json['notifecm_id'].toString(),
        nama: json['nama'].toString(),
        foto: json['foto'].toString(),
        status: json['status'].toString(),
        waktu: json['waktu'].toString());
  }

  Map<String, dynamic> toJson() => {
        'notifecm_id': notifEcmId,
        'nama': nama,
        'foto ': foto,
        'status': status,
        'waktu': waktu
      };
}
