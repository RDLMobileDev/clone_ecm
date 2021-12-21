class EsignModel {
  String? no;
  String? nama;
  String? jabatan;
  String? status;

  EsignModel({this.no, this.nama, this.jabatan, this.status});

  factory EsignModel.fromJson(Map<String, dynamic> json) {
    return EsignModel(
        no: json['no'].toString(),
        nama: json['nama'].toString(),
        jabatan: json['jabatan'].toString(),
        status: json['status'].toString());
  }

  Map<String, dynamic> toJson() =>
      {'no': no, 'nama': nama, 'jabatan ': jabatan};
}
