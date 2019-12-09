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
    final double itemHeight = (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage())).then((onValue){
            ScopedModel.of<PicModel>(context).getdata();
          });
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
            rebuildOnChange: true,
            builder:(context,child,model){
              return  model.picsist.length==0? Center( child: Text("NO Images"),):   GridView.builder(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2/3),
                itemCount: model.picsist.length,
                padding: EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  return Card(
                      child: Imageshow(model.picsist[index]['image'],model.picsist[index]['id']));
                },
              );
            },
          )),
    );
  }

  @override
  void dispose() {

    super.dispose();
  }
}
