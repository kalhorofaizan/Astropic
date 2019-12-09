import 'package:astropic_admin/home.dart';
import 'package:astropic_admin/model/picsmodel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff5CCAFD),
      ),
      home: ScopedModel<PicModel>(
          model: new PicModel(),
          child: Home()),
    );
  }
}
