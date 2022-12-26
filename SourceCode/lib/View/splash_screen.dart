
import 'dart:async';
import 'package:aitask/View/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()
        )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#98DAD9"),
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: HexColor("#98DAD9"),
              statusBarIconBrightness: Brightness.dark),
        ),
        backgroundColor: HexColor("#98DAD9"),
        body: Center(
          child: Text("FlutterSelfie",style:
          TextStyle(fontSize: 18,color: HexColor("#2E424D"),fontFamily: 'ProductSans',fontWeight: FontWeight.bold)),
        )
    );
  }
}

