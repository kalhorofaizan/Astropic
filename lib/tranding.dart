import 'package:astropic_admin/drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'grid_pics.dart';

class Tranding extends StatefulWidget {
  Tranding({Key key}) : super(key: key);

  @override
  _TrandingState createState() => _TrandingState();
}

class _TrandingState extends State<Tranding> {
  List<Map<String, dynamic>> pics=[];

  getdata(){
    Firestore.instance
        .collection("pics")
        .orderBy("setcount", descending: true)
        .getDocuments()
        .then((snapshort) {
      snapshort.documents.forEach((f) async {
        print(f['image']);
        pics.add({"image": f.data["image"], "id": f.documentID});
      });
      setState(() {

      });
    });
  }



  @override
  void initState() {

    getdata();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: (){
              getdata();
            },
            icon: Icon(Icons.refresh,color: Colors.white,),
          )
        ],
        title: Text("Tranding"),
      ),
      body: Container(
        child: pics.length==0 ? Center( child: Text("NO Images"),):  GridPics(pics: pics,),
      ),
    );
  }
}