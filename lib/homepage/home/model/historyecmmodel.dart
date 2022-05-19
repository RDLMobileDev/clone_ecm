class HistoryEcmModel {
  final String ecmId;
  final String date;
  final String lokasi;
  final String classification;
  final String totalHarga;
  final String namaMesin;
  final String noMesin;
  final String problem;
  final List arrayitemrepair;

  HistoryEcmModel(
      this.ecmId,
      this.date,
      this.lokasi,
      this.classification,
      this.totalHarga,
      this.arrayitemrepair,
      this.namaMesin,
      this.noMesin,
      this.problem);

  @override
  String toString() {
    // TODO: implement toString
    return ecmId;
  }
}
