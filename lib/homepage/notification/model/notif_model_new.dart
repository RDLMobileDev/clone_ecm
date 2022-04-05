class NotifModelNew {
  String? idNotif;
  String? nama;
  String? photo;
  String? status;
  String? waktu;

  NotifModelNew({this.idNotif, this.nama, this.photo, this.status, this.waktu});

  factory NotifModelNew.fromJson(Map<String, dynamic> json) {
    return NotifModelNew(
        idNotif: json['id'].toString(),
        nama: json['nama'].toString(),
        photo: json['photo'].toString(),
        status: json['is_read'].toString(),
        waktu: json['waktu'].toString());
  }

  Map<String, dynamic> toJson() => {
        'id': idNotif,
        'nama': nama,
        'photo ': photo,
        'is_read': status,
        'waktu': waktu
      };
}
