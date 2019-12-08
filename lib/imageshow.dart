import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Imageshow extends StatefulWidget {
  final String image;
  Imageshow(this.image,{Key key}) : super(key: key);
  
 
  @override
  _ImageshowState createState() => _ImageshowState();
}

class _ImageshowState extends State<Imageshow> {
  String url="";
  
  @override
  Widget build(BuildContext context) {
    FirebaseStorage.instance.ref().child(widget.image).getDownloadURL().then((onValue){
     if (url=="") {
       setState(() {
         url=onValue;
       });

     }
    });

    print(url);
    return  url=="" ?  Container(
      child: Image.asset(
        'assets/art1.jpg',
        fit: BoxFit.cover,
      ),
      padding: EdgeInsets.all(2),
    ) :Container(
      child: FadeInImage.assetNetwork(
        placeholder: "assets/art1.jpg",
        image: url,
        fit: BoxFit.cover,
        fadeInDuration: Duration(seconds: 3),
      ),
      padding: EdgeInsets.all(2),
    ) ;
  }
}