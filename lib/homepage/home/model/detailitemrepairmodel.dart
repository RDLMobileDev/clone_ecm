class ItemRepairModel {
  String? no;
  String? namaPart;
  String? repairing;
  String? time;
  String? note;

  ItemRepairModel(
      {this.no, this.namaPart, this.repairing, this.time, this.note});

  factory ItemRepairModel.fromJson(Map<String, dynamic> json) {
    return ItemRepairModel(
        no: json['no'].toString(),
        namaPart: json['nama_part'].toString(),
        repairing: json['repairing'].toString(),
        time: json['time'].toString(),
        note: json['note'].toString());
  }

  Map<String, dynamic> toJson() => {
        'no': no,
        'nama_part': namaPart,
        'repairing ': repairing,
        'time': time,
        'note': note
      };
}
