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
  prefs.remove("vendorName");
  prefs.remove("ttlCostOutHouse");
}

// Future<bool> checkDataTemporaryStep6() async {
//   final prefs = await SharedPreferences.getInstance();
//   String check = prefs.getString("check").toString();
//   String repair = prefs.getString("repair").toString();
//   String totalcr = prefs.getString("totalcr").toString();
//   String breaks = prefs.getString("breaks").toString();
//   String lineStart = prefs.getString("lineStart").toString();
//   String lineStop = prefs.getString("lineStop").toString();
//   String ttlLineStop = prefs.getString("ttlLineStop").toString();
//   String costH = prefs.getString("costH").toString();
//   String costMp = prefs.getString("costMp").toString();
//   String costInHouse = prefs.getString("costInHouse").toString();
//   String outHouseH = prefs.getString("outHouseH").toString();
//   String outHouseMp = prefs.getString("outHouseMp").toString();
//   String outHouseCost = prefs.getString("outHouseCost").toString();
//   String ttlCostOutHouse = prefs.getString("ttlCostOutHouse").toString();

//   if ((check.isEmpty || check == "") &&
//           (repair.isEmpty || repair == "") &&
//           (totalcr.isEmpty || totalcr == "") &&
//           (lineStart.isEmpty || lineStart == "" || lineStart == "0") &&
//           (breaks.isEmpty || breaks == "") &&
//           (lineStop.isEmpty || lineStop == "") ||
//       (ttlLineStop.isEmpty || ttlLineStop == "") &&
//           (costH.isEmpty || costH == "" || costH == "0") &&
//           (costMp.isEmpty || costMp == "" || costMp == "0") &&
//           (costInHouse.isEmpty || costInHouse == "" || costInHouse == "0") &&
//           (outHouseH.isEmpty || outHouseH == "") &&
//           (outHouseMp.isEmpty || outHouseMp == "") &&
//           (outHouseCost.isEmpty || outHouseCost == "") &&
//           (ttlCostOutHouse.isEmpty ||
//               ttlCostOutHouse == "" ||
//               ttlCostOutHouse == "0")) {
//     return false;
//   } else {
//     return true;
//   }
// }
