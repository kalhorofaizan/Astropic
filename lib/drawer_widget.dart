import 'package:astropic_admin/catogaries_page.dart';
import 'package:astropic_admin/favorites_pages.dart';
import 'package:astropic_admin/home.dart';
import 'package:astropic_admin/tranding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  bool home=true;
  bool fav=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      color: Color(0xff4f5b62),
      child: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "ASTROPIC",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Anton-Regular'),
                    ))),
          ),
          ListTile(
            selected: home,
            onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
            },
            title: Text("Home",style:TextStyle(color: Colors.white),),
            leading: Icon(Icons.home,color: Colors.white,),
          ),
          ListTile(
            title: Text("Catogaries",style:TextStyle(color: Colors.white),),
            leading: Icon(Icons.category,color: Colors.white,),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CatogariesPage()));
            },
          ),
          ListTile(
            title: Text("Tranding",style:TextStyle(color: Colors.white),),
            leading: Icon(Icons.trending_up,color: Colors.white,),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Tranding()));
            },
          ),
          ListTile(
            selected: fav,
            title: Text("Favorites",style:TextStyle(color: Colors.white),),
            leading: Icon(Icons.favorite,color: Colors.white,),
            onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FavoritesPages()));
            },
          ),
        ],
      ),
    );
  }
}
