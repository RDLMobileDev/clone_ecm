class SparepartModel {
  String? no;
  String? namaPart;
  String? qty;
  String? total;
  String? totalHarga;

  SparepartModel(
      {this.no, this.namaPart, this.qty, this.total, this.totalHarga});

  factory SparepartModel.fromJson(Map<String, dynamic> json) {
    return SparepartModel(
        no: json['no'].toString(),
        namaPart: json['nama_part'].toString(),
        qty: json['qty'].toString(),
        total: json['total'].toString(),
        totalHarga: json['total_harga'].toString());
  }

  Map<String, dynamic> toJson() => {
        'no': no,
        'nama_part': namaPart,
        'qty ': qty,
        'total': total,
        'total_harga': totalHarga
      };
}
