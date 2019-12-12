import 'dart:async';

import 'package:astropic_admin/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var connect=true;

  @override
  Widget build(BuildContext context) {
    Timer timer = new Timer(new Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home()));
    });

    return Scaffold(
      body: Container(
        color: Color(0xff949599),
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset('assets/sp.jpeg'),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
