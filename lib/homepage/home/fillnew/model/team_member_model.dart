class TeamMemberModel {
  String? teamMemberId;
  String? userId;
  String? ecmId;
  String? createdAt;
  String? updatedAt;

  TeamMemberModel(
      {this.teamMemberId,
      this.userId,
      this.ecmId,
      this.createdAt,
      this.updatedAt});

  factory TeamMemberModel.fromJson(dynamic json) {
    return TeamMemberModel(
      teamMemberId: json['m_teammember_id'].toString(),
      userId: json['user_id'].toString(),
      ecmId: json['t_ecm_id'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
    );
  }
}
