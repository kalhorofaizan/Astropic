import 'package:astropic_admin/grid_pics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowCatoga extends StatefulWidget {
  final String cato;

  ShowCatoga(this.cato,{Key key}) : super(key: key);

  @override
  _ShowCatogaState createState() => _ShowCatogaState();
}

class _ShowCatogaState extends State<ShowCatoga> {

  List<Map<String, dynamic>> pics=[];


  getdata(){
    Firestore.instance
        .collection("pics").where("category", isEqualTo: widget.cato)
        .orderBy("add_time", descending: true)
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
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: (){
             getdata();
            },
            icon: Icon(Icons.refresh,color: Colors.white,),
          )
        ],
        title: Text(widget.cato),
      ),
      body: Container(
            child: pics.length==0 ? Center( child: CircularProgressIndicator(),):  GridPics(pics: pics,),
      ),
    );
  }
}