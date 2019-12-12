import 'package:astropic_admin/model/picsmodel.dart';
import 'package:astropic_admin/splash_screen.dart';
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

    return ScopedModel<PicModel>(
      model: new PicModel(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff212121),
          backgroundColor: Color(0xff000000),
          scaffoldBackgroundColor: Color(0xff484848),
          canvasColor: Color(0xff484848),
          accentColor: Color(0xff65499c),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
