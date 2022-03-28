import 'package:get_storage/get_storage.dart';

class SharedPrefsUtil {
  static final storagePrefs = GetStorage();
  static const String idKeyUser = "idKeyUser";
  static const String tokenKey = "tokenKey";
  static const String idEcm = "idEcm";
  static const String ecmIdEdit = "ecmIdEdit";

  static const String idJabatan = "jabatanKey";
  static const String namaJabatanKey = "namaJabatanKey";
  static const String emailKey = "emailKey";
  static const String deviceKey = "deviceKey";
  static const String usernameKey = "usernameKey";
  static const String photoUserKey = "photoUser";

  static const String idMesinRes = "idMesinRes";
  static const String idEcmItem = "idEcmItem";

  static const String namaKlasifikasi = "namaKlasifikasi";
  static const String idUserChecker = "idUserChecker";
  static const String userChecker = "userStep4";

  static void setIdUser(String idUser) {
    storagePrefs.write(idKeyUser, idUser);
  }

  static void setTokenUser(String tokenUser) {
    storagePrefs.write(tokenKey, tokenUser);
  }

  static void setEcmId(String ecmIdSaved) {
    storagePrefs.write(idEcm, ecmIdSaved);
  }

  static void setEcmIdForEdit(String ecmId) {
    storagePrefs.write(ecmIdEdit, ecmId);
  }

  static void setIdJabatanKey(String idJabatanUser) {
    storagePrefs.write(idJabatan, idJabatanUser);
  }

  static void setNamaJabatanKey(String namaJabatanUser) {
    storagePrefs.write(namaJabatanKey, namaJabatanUser);
  }

  static void setEmailKey(String emailUser) {
    storagePrefs.write(emailKey, emailUser);
  }

  static void setDeviceKey(String deviceKeyUser) {
    storagePrefs.write(deviceKey, deviceKeyUser);
  }

  static void setUsername(String username) {
    storagePrefs.write(usernameKey, username);
  }

  static void setPhotoUser(String photoUser) {
    storagePrefs.write(photoUserKey, photoUser);
  }

  static void setIdMesinRes(String idMesin) {
    storagePrefs.write(idMesinRes, idMesin);
  }

  static void setNamaKlasifikasi(String klasifikasi) {
    storagePrefs.write(namaKlasifikasi, klasifikasi);
  }

  static void setIdEcmItem(String idEcmItemRes) {
    storagePrefs.write(idEcmItem, idEcmItemRes);
  }

  static void setIdUserChecker(String idUser) {
    storagePrefs.write(idUserChecker, idUser);
  }

  static void setNameUserChecker(String name) {
    storagePrefs.write(userChecker, name);
  }

  static String getIdUser() {
    return storagePrefs.read(idKeyUser) ?? "";
  }

  static String getTokenUser() {
    return storagePrefs.read(tokenKey) ?? "";
  }

  static String getEcmId() {
    return storagePrefs.read(idEcm) ?? "";
  }

  static String getEcmIdEdit() {
    return storagePrefs.read(ecmIdEdit) ?? "";
  }

  static String getIdJabatanKey() {
    return storagePrefs.read(idJabatan);
  }

  static String getNamaJabatanKey() {
    return storagePrefs.read(namaJabatanKey);
  }

  static String getEmailKey() {
    return storagePrefs.read(emailKey) ?? "";
  }

  static String getDeviceKey() {
    return storagePrefs.read(deviceKey) ?? "";
  }

  static String getUsername() {
    return storagePrefs.read(usernameKey) ?? "";
  }

  static String getPhotoUser() {
    return storagePrefs.read(photoUserKey);
  }

  static String getIdMesinRes() {
    return storagePrefs.read(idMesinRes) ?? "";
  }

  static String getNamaKlasifikasi() {
    return storagePrefs.read(namaKlasifikasi) ?? "";
  }

  static String getIdEcmItem() {
    return storagePrefs.read(idEcmItem) ?? "";
  }

  static String getIdUserChecker() {
    return storagePrefs.read(idUserChecker) ?? "";
  }

  static String getNameUserChecker() {
    return storagePrefs.read(userChecker) ?? "";
  }

  static void clearStorage() {
    storagePrefs.erase();
  }

  static void clearEcmId() {
    storagePrefs.remove(idEcm);
  }

  static void clearEcmIdEdit() {
    storagePrefs.remove(ecmIdEdit);
  }
}
