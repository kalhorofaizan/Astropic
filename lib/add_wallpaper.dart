import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  TextEditingController _textEditingController=TextEditingController();
  var _image;
  var cat="Art";
  bool change=false;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  uploadImage(){
    var name=randomAlphaNumeric(10);
    FirebaseStorage.instance.ref().child(name).putFile(_image);
    Firestore.instance.collection('pics').add({
      "add_time":Timestamp.now(),
      "category":cat,
      "image":name,
      "setcount":0
    });
    setState(() {
      _image=null;
      change=true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add",
          style: TextStyle(color: Colors.white),
        ),
          iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                width: 90,
                child: DropdownButton<String>(
                  style: TextStyle(
                      color: Colors.white,
                  ),
                  value: cat,
                  items: <String>['Art', 'Design', 'Quote'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                  setState(() {
                    cat=value;
                  });
                  },
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width*0.6,
                  height: MediaQuery.of(context).size.height*0.5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: _image == null
                        ? Text('No image selected.',style: TextStyle(
                      color: Colors.white
                    ),)
                        : Image.file(_image),
                  ),
                ),
              ),
              Center(child: RaisedButton(onPressed: getImage,child: Text("Select Image"),color: Color(0xff2286c3),),),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(child: RaisedButton(child: Text("UPLOAD"),color: Color(0xff65499c),onPressed:(){
                  uploadImage();
                  Fluttertoast.showToast(
                      msg: "Success Full uploaded",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1
                  );
                },),width: double.infinity,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
