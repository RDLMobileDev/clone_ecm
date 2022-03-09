import 'package:e_cm/homepage/home/fillnew/model/team_member_model.dart';

class StepFillSatuModel {
  String? ecmId;
  String? classificationId;
  String? tanggal;
  List<TeamMemberModel>? teamMember;
  String? factory;
  String? groupFactory;
  String? machineId;
  String? machineDetailId;

  StepFillSatuModel(
      {this.ecmId,
      this.classificationId,
      this.tanggal,
      this.teamMember,
      this.factory,
      this.groupFactory,
      this.machineId,
      this.machineDetailId});

  factory StepFillSatuModel.fromJson(dynamic json) {
    return StepFillSatuModel(
      ecmId: json['t_ecm_id'].toString(),
      classificationId: json['classification_id'].toString(),
      tanggal: json['classification_id'].toString(),
      teamMember: List<TeamMemberModel>.from(
          json["team_member"].map((x) => TeamMemberModel.fromJson(x))),
      factory: json['factory'].toString(),
      groupFactory: json['group_factory'].toString(),
      machineId: json['machine_id'].toString(),
      machineDetailId: json['machinedetail_id'].toString(),
    );
  }
}
