import 'package:astropic_admin/model/picsmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BigImage extends StatefulWidget {
  final String url;
  final String id;
  final String name;
  BigImage( this.url,this.id ,this.name, {Key key}) : super(key: key);
  @override
  _BigImageState createState() => _BigImageState();
}

class _BigImageState extends State<BigImage> {


  delete(){
    Firestore.instance.collection('pics').document(widget.id).delete().then((onValue){
      FirebaseStorage.instance.ref().child(widget.name).delete().then((onValue){
      Navigator.pop(context,true);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Hero(
              tag: widget.url,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/art1.jpg",
                  image: widget.url,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(seconds: 3),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: (){

                        },child: Text("Set As Wallpaper"),color: Color(0xff5CCAFD),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: (){
                          delete();
                        },child: Text("delete"),color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}