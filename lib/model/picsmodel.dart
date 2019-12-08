import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
class PicModel extends Model{
  List<Map<String,dynamic>> __picslist=[];
  List<Map<String,dynamic>> get picsist=>__picslist;
  geturl(String image)  async {
    var url= await FirebaseStorage.instance.ref().child(image).getDownloadURL();
    return url;
  }

  getdata() async {
    __picslist=[];
    Firestore.instance
        .collection("pics")
        .orderBy("add_time",descending: true)
        .getDocuments()
        .then((snapshort) {
      snapshort.documents.forEach((f)async {
       __picslist.add(f.data);
      });
      notifyListeners();
    });
  }
  PicModel(){

    getdata();
  }


}