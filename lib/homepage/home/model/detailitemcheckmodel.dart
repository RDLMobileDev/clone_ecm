class ItemCheckModel {
  String? no;
  String? namaPart;
  String? namaStandar;
  String? actual;
  String? time;
  String? note;

  ItemCheckModel(
      {this.no,
      this.namaPart,
      this.namaStandar,
      this.actual,
      this.time,
      this.note});

  factory ItemCheckModel.fromJson(Map<String, dynamic> json) {
    return ItemCheckModel(
        no: json['no'].toString(),
        namaPart: json['nama_part'].toString(),
        namaStandar: json['nama_standar'].toString(),
        actual: json['actual'].toString(),
        time: json['time'].toString(),
        note: json['note'].toString());
  }

  Map<String, dynamic> toJson() => {
        'no': no,
        'nama_part': namaPart,
        'nama_standar ': namaStandar,
        'actual': actual,
        'time': time,
        'note': note
      };
}
