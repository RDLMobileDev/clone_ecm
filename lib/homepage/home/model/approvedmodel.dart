class ApprovedModel {
  String? notifEcmId;
  String? nama;
  String? foto;
  String? status;

  ApprovedModel({this.notifEcmId, this.nama, this.foto, this.status});

  factory ApprovedModel.fromJson(Map<String, dynamic> json) {
    return ApprovedModel(
        notifEcmId: json['notifecm_id'].toString(),
        nama: json['nama'].toString(),
        foto: json['foto'].toString(),
        status: json['status'].toString());
  }

  Map<String, dynamic> toJson() => {
        'notifecm_id': notifEcmId,
        'nama': nama,
        'foto ': foto,
        'status': status
      };
}
