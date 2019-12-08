

import 'package:astropic_admin/add_page.dart';
import 'package:astropic_admin/imageshow.dart';
import 'package:astropic_admin/model/picsmodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  StorageReference photoref=FirebaseStorage.instance.ref().child('Art');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage()));
      },),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: (){
              ScopedModel.of<PicModel>(context).getdata();
            },
            icon: Icon(Icons.refresh,color: Colors.white,),
          )
        ],
        title: Text(
          "Astropic",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          child: ScopedModelDescendant<PicModel>(
            builder:(context,child,model){
              return GridView.builder(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: model.picsist.length,
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index) {
                print(model.picsist);
                print("1");
                  return Imageshow(model.picsist[index]['image']);
                },
              );
            },
          )),
    );
  }
}
