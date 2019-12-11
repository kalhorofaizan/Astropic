import 'dart:io';
import 'package:astropic_admin/big_image.dart';
import 'package:astropic_admin/model/picsmodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Imageshow extends StatefulWidget {
  final String image;
  final String id;
  Imageshow(this.image,{this.id,Key key}) : super(key: key);

  @override
  _ImageshowState createState() => _ImageshowState();
}

class _ImageshowState extends State<Imageshow> {
  String url="";
  bool fav=false;


  setfav(){
    ScopedModel.of<PicModel>(context).setfavorite(widget.image);
    fav=true;
  }
  removefav(){
    ScopedModel.of<PicModel>(context).removefavorites(widget.image);
    fav=false;
  }



  @override
  Widget build(BuildContext context) {
    try{
      if (url=="") {
        FirebaseStorage.instance.ref().child(widget.image).getDownloadURL().then((onValue){
          setState(() {
            url=onValue;
            fav =ScopedModel.of<PicModel>(context).chackfavorites(widget.image);
          });
        }).catchError((onError){
          removefav();
          print("soakdsadsa");
          print(onError);
        });
      }

    } on Platform catch (e){
      print(e);
    }
    return  url=="" ?  Container(
      child: Image.asset(
        'assets/pp.png',
        fit: BoxFit.cover,
      ),
    ) :   InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BigImage(url,widget.image,fav,setfav: setfav,removefav: this.removefav,id: widget.id))).then((onValue){
//       if (onValue!=null) {
//         if (onValue) {
//         //  ScopedModel.of<PicModel>(context).getdata();
//         }
//       }
        });
      },
      child: Hero(tag: url,
        child: FadeInImage.assetNetwork(
          placeholder: "assets/pp.png",
          image: url,
          fit: BoxFit.cover,
          fadeInDuration: Duration(seconds: 2),
        ),
      ),
    ) ;
  }
  @override
  void dispose() {
    super.dispose();
  }
}