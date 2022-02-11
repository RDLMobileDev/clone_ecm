// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:e_cm/auth/service/apilogin.dart';
import 'package:e_cm/homepage/dashboard.dart';
import 'package:e_cm/homepage/home/services/remove_ecm_cancel_service.dart';
import 'package:e_cm/util/local_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:platform_device_id/platform_device_id.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  LocalNotification.show(
      message.data["title"] ?? "", message.data["body"] ?? "");

  if (message.notification != null) {
    LocalNotification.show(
        message.notification?.title ?? "", message.notification?.body ?? "");
  }
}

class _LogInState extends State<LogIn> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool rememberMeState = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isEmailError = false;
  bool _isPasswordError = false;
  bool _initialEnabledButton = false;
  String? deviceUser = "";
  late final FirebaseMessaging _firebaseMessaging;
  String locale = Platform.localeName;

  static const _localizedValues = <String, Map<String, String>>{
    'en_US': {
      'login_sukses': 'Login Success',
      'login_gagal': 'Wrong username/password',
      'device_lain': 'You are logged in using another device',
      'update': 'Please update the latest version',
      'check': 'Check your connection',
      'problem': 'There was a problem with your connection',
      'format_email': 'Email format is invalid',
      'format_password': 'Password cannot be empty'
    },
    'id_ID': {
      'login_sukses': 'Login sukses',
      'login_gagal': 'Username/password salah',
      'device_lain': 'Anda login menggunakan device lain',
      'update': 'Silahkan update versi terbaru',
      'check': 'Periksa koneksi internet',
      'problem': 'Terjadi masalah pada koneksi Anda',
      'format_email': 'Format email tidak benar',
      'format_password': 'Kata sandi tidak boleh kosong'
    },
  };

  // static List<String> languages() => _localizedValues.keys.toList();

  getDeviceKey() async {
    var deviceKey = await PlatformDeviceId.getDeviceId;
    print("device_key = " + deviceKey!);
    return deviceKey;
  }

  void removeEcmNotCompleted() async {
    // idKeyUser
    // hapus data ecm card jika session kosong
    final prefs = await _prefs;
    String idUser = prefs.getString("idKeyUser") ?? "";
    String tokenUser = prefs.getString("tokenKey") ?? "";

    print(idUser);
    print(tokenUser);

    if (idUser.isNotEmpty || idUser != "") {
      var result =
          await removeEcmCancelUser.removeEcmNotCompleted(tokenUser, idUser);
      print("hapussss");

      print(result);
    }
  }

  postLogin() async {
    String emailUser = _emailController.text;
    String passwordUser = _passwordController.text;
    String versionUser = "1.0.1";

    try {
      var rspLogin = await loginUser(
          emailUser, passwordUser, deviceUser.toString(), versionUser);
      print(rspLogin);

      if (rspLogin['response']['status'] == 200) {
        final SharedPreferences prefs = await _prefs;

        prefs.setString("idKeyUser", rspLogin['data']['user']['id'].toString());
        prefs.setString("emailKey", rspLogin['data']['user']['email']);
        prefs.setString("deviceKey", deviceUser ?? "");
        prefs.setString("tokenKey", rspLogin['data']['token']);
        prefs.setString("usernameKey", rspLogin['data']['user']['username']);
        prefs.setInt("jabatanKey", rspLogin['data']['user']['jabatan']);
        prefs.setString(
            "namaJabatanKey", rspLogin['data']['user']['namajabatan']);
        prefs.setString(
            "photoUser", rspLogin['data']['user']['photo'].toString());

        print("ID user = " + (rspLogin['data']['user']['id']).toString());
        print("EMAIL user = " + rspLogin['data']['user']['email']);
        print("USERNAME user = " + rspLogin['data']['user']['username']);
        print("TOKEN user = " + rspLogin['data']['token']);
        print("JABATAN user = " + rspLogin['data']['user']['namajabatan']);

        removeEcmNotCompleted();

        setState(() {
          Fluttertoast.showToast(
              msg: _localizedValues[locale]!['login_sukses']!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16);
        });

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
            ModalRoute.withName("/"));

        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const Dashboard()));
      } else if (rspLogin['response']['status'] == 201) {
        setState(() {
          Fluttertoast.showToast(
              msg: _localizedValues[locale]!['login_gagal']!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16);
        });
      } else if (rspLogin['response']['status'] == 202) {
        setState(() {
          Fluttertoast.showToast(
              msg: _localizedValues[locale]!['device_lain']!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16);
        });
      } else if (rspLogin['response']['status'] == 203) {
        // setState(() {
        //   Fluttertoast.showToast(
        //       msg: _localizedValues[locale]!['update']!,
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.BOTTOM,
        //       timeInSecForIosWeb: 2,
        //       backgroundColor: Colors.greenAccent,
        //       textColor: Colors.white,
        //       fontSize: 16);
        // });
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Update ECM'),
            content: const Text('Silahkan update ECM versi terbaru'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Exit'),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          Fluttertoast.showToast(
              msg: _localizedValues[locale]!['check']!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16);
        });
      }
    } on SocketException catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: _localizedValues[locale]!['problem'] ??
              'Terjadi masalah pada koneksi Anda',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16);
    } on TimeoutException catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: _localizedValues[locale]!['problem'] ??
              'Terjadi masalah pada koneksi Anda',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16);
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: _localizedValues[locale]!['problem'] ??
              'Terjadi masalah pada koneksi Anda',
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16);
    }
  }

  void initFcmSetup() async {
    try {
      _firebaseMessaging = FirebaseMessaging.instance;
      deviceUser = await _firebaseMessaging.getToken();

      // ask permission on ios
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        Fluttertoast.showToast(
            msg: 'Notification permission are needed to use this app',
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
      }

      FirebaseMessaging.onMessage.listen((event) {
        LocalNotification.show(
            event.data["title"] ?? "", event.data["body"] ?? "");

        if (event.notification != null) {
          LocalNotification.show(
              event.notification?.title ?? "", event.notification?.body ?? "");
        }
      });

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } on SocketException catch (e) {
      print("Socket Exception:");
      print(e);
    } on TimeoutException catch (e) {
      print("Timeout Exception:");
      print(e);
    } on Exception catch (e) {
      print("Exception:");
      print(e);
    } catch (e) {
      print("catch");
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    if (Platform.localeName != "en_US" || Platform.localeName != "id_ID") {
      setState(() {
        locale = "en_US";
      });
    }

    getDeviceKey();

    initFcmSetup();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogInEnabled =
        !_isEmailError && !_isPasswordError && _initialEnabledButton;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(24, 76, 24, 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back.",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 32,
                          color: Color(0xFF00AEDB),
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Log in to your account",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Email',
                        suffixStyle: TextStyle(color: Colors.green),
                        errorText: _isEmailError
                            ? _localizedValues[locale]!['format_email']
                            : null,
                      ),
                      textInputAction: TextInputAction.next,
                      inputFormatters: [LengthLimitingTextInputFormatter(40)],
                      onFieldSubmitted: (value) {
                        setState(() {
                          _isEmailError =
                              !(value.isNotEmpty && value.contains("@"));
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _isEmailError =
                              !(value.isNotEmpty && value.contains("@"));
                        });
                      },
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Focus(
                      onFocusChange: (isFocused) {
                        setState(() {
                          if (isFocused &&
                              _passwordController.text.isNotEmpty) {
                            _initialEnabledButton =
                                !_isEmailError && !_isPasswordError;
                          }
                        });
                      },
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Password',
                          suffixStyle: TextStyle(color: Colors.green),
                          errorText: _isPasswordError
                              ? _localizedValues[locale]!['format_password']
                              : null,
                        ),
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(40),
                        ],
                        onFieldSubmitted: (value) {
                          setState(() {
                            _isPasswordError = value.isEmpty;
                            _initialEnabledButton =
                                !_isEmailError && !_isPasswordError;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _isPasswordError = value.isEmpty;
                            _initialEnabledButton =
                                !_isEmailError && !_isPasswordError;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: Text(
                    //     "Forgot Password",
                    //     style: TextStyle(
                    //         fontFamily: 'Rubik',
                    //         fontSize: 16,
                    //         color: Color(0xFF00AEDB),
                    //         fontWeight: FontWeight.w400),
                    //   ),
                    // ),
                    SizedBox(
                      height: 48,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ))),
                        onPressed: isLogInEnabled
                            ? () {
                                postLogin();
                              }
                            : null,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    Container(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            TextSpan(
                              text: "By continuing, you agree to our ",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Color(0xff404446)),
                            ),
                            TextSpan(
                              text: "Terms of Service ",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Color(0xff00AEDB)),
                            ),
                            TextSpan(
                              text: "\nand ",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Color(0xff404446)),
                            ),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Color(0xff00AEDB)),
                            ),
                            TextSpan(
                              text: ".",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Color(0xff404446)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
