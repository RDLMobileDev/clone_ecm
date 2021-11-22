class UserModel {
  String idUser;
  String emailUser;
  String deviceUser;
  String roleUser;

  UserModel(
      {required this.idUser,
      required this.emailUser,
      required this.deviceUser,
      required this.roleUser});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        idUser: json['id'].toString(),
        emailUser: json['email'],
        deviceUser: json['device_key'],
        roleUser: json['role']);
  }

  Map<String, dynamic> toJson() => {
        'id': idUser,
        'email': emailUser,
        'device_key': deviceUser,
        'role': roleUser
      };
}
