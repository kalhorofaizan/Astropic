import 'package:astropic_admin/add_wallpaper.dart';
import 'package:astropic_admin/grid_pics.dart';
import 'package:astropic_admin/model/picsmodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './drawer_widget.dart';
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
      drawer: DrawerWidget(),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage())).then((onValue){
            ScopedModel.of<PicModel>(context).getdata();
          });
      },),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
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
            rebuildOnChange: true,
            builder:(context,child,model){
              return  model.picsist.length==0? Center( child: CircularProgressIndicator(),):  GridPics(pics: model.picsist,);
            },
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
