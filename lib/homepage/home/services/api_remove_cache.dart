import 'package:shared_preferences/shared_preferences.dart';

void removeStepCacheFillEcm() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove("classBool");
  prefs.remove("dateBool");
  prefs.remove("teamMemberBool");
  prefs.remove("locationBool");
  prefs.remove("machineNameBool");
  prefs.remove("machineDetailBool");
  prefs.remove("shiftBool");
  prefs.remove("timeBool");
  prefs.remove("ketikProblemBool");
  prefs.remove("percentBool");
  prefs.remove("imageUploadBool");
  prefs.remove("whyBool1");
  prefs.remove("whyBool2");
  prefs.remove("whyBool3");
  prefs.remove("howBool");
  prefs.remove("itemStep4Bool");
  prefs.remove("itemRepairBool");
  prefs.remove("userNameBool");
  prefs.remove("ideaBool");
  prefs.remove("breakTimeBool");
  prefs.remove("outHouseHBool");
  prefs.remove("outHouseMpBool");
  prefs.remove("outHouseCostBool");
  prefs.remove("sparePartBool");
  prefs.remove("copyToBool");
}

void removeCacheFillEcm() async {
  final prefs = await SharedPreferences.getInstance();
  // remove session step 1
  prefs.remove("namaKlasifikasi");
  prefs.remove("tglStepSatu");
  prefs.remove("namaMember");
  prefs.remove("namaLokasi");
  prefs.remove("namaGroupLokasi");
  prefs.remove("machineId");
  prefs.remove("machineDetailId");

  // remove session step 2
  prefs.remove("shiftA");
  prefs.remove("shiftB");
  prefs.remove("shiftC");
  prefs.remove("timePickState");
  prefs.remove("problemTypeState");
  prefs.remove("safetyOpt");
  prefs.remove("qualityOpt");
  prefs.remove("deliveryOpt");
  prefs.remove("costOpt");
  prefs.remove("moldingOpt");
  prefs.remove("utilityOpt");
  prefs.remove("productionOpt");
  prefs.remove("engineerOpt");
  prefs.remove("otherOpt");
  prefs.remove("imagesKetPath");

  // remove session step 3
  prefs.remove("why1");
  prefs.remove("why2");
  prefs.remove("why3");
  prefs.remove("why4");
  prefs.remove("howC");

  // remove session step 6
  prefs.remove("namaImprovement");
  prefs.remove("idea");
  prefs.remove("breakHours");
  prefs.remove("breakMinutes");
  prefs.remove("outHouseH");
  prefs.remove("outHouseMp");
  prefs.remove("outHouseCost");
}
