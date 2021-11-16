import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    alignment: Alignment.center,
                    image: new AssetImage("assets/images/splash_screen.png"),
                    fit: BoxFit.fitWidth)),
          ),
          Center(
            child: Container(
              width: 210,
              height: 110,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      alignment: Alignment.center,
                      image: new AssetImage("assets/images/logo_sugity.png"),
                      fit: BoxFit.contain)),
            ),
          )
        ],
      ),
    );
  }
}
