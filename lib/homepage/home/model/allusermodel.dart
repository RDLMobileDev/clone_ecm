class AllUserModel {
  String? userId;
  String? userName;
  String? userFullName;

  AllUserModel({this.userId, this.userName, this.userFullName});

  factory AllUserModel.fromJson(Map<String, dynamic> json) {
    return AllUserModel(
        userId: json['id'].toString(),
        userName: json['username'],
        userFullName: json['fullname']);
  }

  Map<String, dynamic> toJson() =>
      {'id'.toString(): userId, 'username': userName, 'fullname': userFullName};
}
