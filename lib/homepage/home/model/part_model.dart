class PartModel {
  int? mPartId;
  int? mMachineId;
  String? mPartNama;
  String? mPartStandard;
  String? mPartStock;
  String? mPartHarga;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  PartModel(
      {this.mPartId,
      this.mMachineId,
      this.mPartNama,
      this.mPartStandard,
      this.mPartStock,
      this.mPartHarga,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  PartModel._empty();

  PartModel.fromJson(Map<String, dynamic> json) {
    mPartId = json['m_part_id'];
    mMachineId = json['m_machine_id'];
    mPartNama = json['m_part_nama'];
    mPartStandard = json['m_part_standard'];
    mPartStock = json['m_part_stock'];
    mPartHarga = json['m_part_harga'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m_part_id'] = this.mPartId;
    data['m_machine_id'] = this.mMachineId;
    data['m_part_nama'] = this.mPartNama;
    data['m_part_standard'] = this.mPartStandard;
    data['m_part_stock'] = this.mPartStock;
    data['m_part_harga'] = this.mPartHarga;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'PartModel{mPartId: $mPartId, mMachineId: $mMachineId, mPartNama: $mPartNama, mPartStandard: $mPartStandard, mPartStock: $mPartStock, mPartHarga: $mPartHarga, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
