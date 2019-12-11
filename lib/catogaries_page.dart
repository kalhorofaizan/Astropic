import 'package:astropic_admin/drawer_widget.dart';
import 'package:astropic_admin/show_catoga.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CatogariesPage extends StatefulWidget {
  @override
  _CatogariesPageState createState() => _CatogariesPageState();
}

class _CatogariesPageState extends State<CatogariesPage> {
  
  sendpage(name){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShowCatoga(name)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text("Catogaries"),
      ),
      body: Container(
        width:MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                  image: AssetImage('assets/artcat.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width*0.6,
              height: MediaQuery.of(context).size.height*0.17,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: (){
                  sendpage("Art");
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text("ART",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.05),),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                  image: AssetImage('assets/designcat.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width*0.6,
              height: MediaQuery.of(context).size.height*0.17,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: (){
                  sendpage("Design");
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text("DESIGN",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.05),),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
                  image: AssetImage('assets/quotescat.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width*0.6,
              height: MediaQuery.of(context).size.height*0.17,
              child: InkWell(
                splashColor: Colors.white,
                borderRadius: BorderRadius.circular(15),
                onTap: (){
                  sendpage("Quote");
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text("QUOTES",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.05),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
