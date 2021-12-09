class LangModel {
  // variable untuk bahasa
  String? homeName;
  String? notifName;
  String? accountName;

  LangModel({this.homeName, this.notifName, this.accountName});

  factory LangModel.fromJson(dynamic obj) {
    return LangModel(
      homeName: obj['menu_nav']['home'],
      notifName: obj['menu_nav']['notif'],
      accountName: obj['menu_nav']['account'],
    );
  }
}
