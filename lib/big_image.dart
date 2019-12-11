import 'package:astropic_admin/model/picsmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wallpaper/wallpaper.dart';

class BigImage extends StatefulWidget {
  final String url;
  String id;
  final String name;
  bool fav;
  final Function setfav;
  final Function removefav;
  BigImage( this.url ,this.name,this.fav,{this.setfav,this.id,this.removefav,Key key}) : super(key: key);
  @override
  _BigImageState createState() => _BigImageState();
}

class _BigImageState extends State<BigImage> {
  var res;
  var downloading;
  var home;

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
                  placeholder: "assets/pp.png",
                  image: widget.url,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(seconds: 2),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 30,
              child: widget.fav?  IconButton(icon: Icon(Icons.favorite,color: Colors.red,),onPressed: (){
                widget.removefav();
                setState(() {
                  widget.fav=!widget.fav;
                });
              },) : IconButton(icon: Icon(Icons.favorite_border),onPressed: (){
                widget.setfav();
                setState(() {
                  widget.fav=!widget.fav;
                });
              },) ,
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

                          if (widget.id!="") {
                            Firestore.instance.collection('pics').document(widget.id).get().then((onValue){
                              print(widget.id);
                            var image=onValue['image'];
                            var cat=onValue['category'];
                            var setcount=onValue['setcount']+1;
                            var time=onValue['add_time'];
                            Firestore.instance.collection('pics').document(widget.id).updateData({
                              "image":image,
                              "category":cat,
                              "setcount":setcount,
                              "add_time":time,
                            });
                            });
                          }
                          var progressString =
                          Wallpaper.ImageDownloadProgress(widget.url);
                          progressString.listen((data1) {
                            setState(() {
                              res = data1;
                              downloading = true;
                            });
                            print("DataReceived: " + data1);
                          }, onDone: () async {
                            home = await Wallpaper.homeScreen();
                            Fluttertoast.showToast(
                                msg: "Success Full uploaded",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIos: 1
                            );
                            setState(() {
                              downloading = false;
                              home = home;
                            });
                            print("Task Done");
                          }, onError: (error) {
                            setState(() {
                              downloading = false;
                            });
                            print("Some Error");
                          });
                        },child: Text("Set As Wallpaper"),color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  widget.id!=null ? Expanded(
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: (){
                          delete();
                        },child: Text("delete"),color: Colors.red,
                      ),
                    ),
                  ):Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}