import 'dart:io';

import 'package:astropic_admin/big_image.dart';
import 'package:astropic_admin/model/picsmodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Imageshow extends StatefulWidget {
  final String image;
  final String id;
  Imageshow(this.image,this.id,{Key key}) : super(key: key);
  
 
  @override
  _ImageshowState createState() => _ImageshowState();
}

class _ImageshowState extends State<Imageshow> {
  String url="";
  
  @override
  Widget build(BuildContext context) {
    try{
      FirebaseStorage.instance.ref().child(widget.image).getDownloadURL().then((onValue){
        if (url=="") {
          setState(() {
            url=onValue;
          });

        }
    }   );
    } on Platform catch (e){
      print(e);
    }
    return  url=="" ?  Container(
      child: Image.asset(
        'assets/art1.jpg',
        fit: BoxFit.cover,
      ),
    ) :   InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BigImage(url,widget.id,widget.image))).then((onValue){
       if (onValue) {
         ScopedModel.of<PicModel>(context).getdata();
       }
        });
      },
      child: Hero(tag: url,
        child: FadeInImage.assetNetwork(
          placeholder: "assets/art1.jpg",
          image: url,
          fit: BoxFit.cover,
          fadeInDuration: Duration(seconds: 3),
        ),
      ),
    ) ;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}