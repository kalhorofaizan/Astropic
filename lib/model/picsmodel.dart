import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class PicModel extends Model{
  List<Map<String,dynamic>> __picslist=[];
  List<Map<String,dynamic>> get picsist=>__picslist;
  var _user;
  geturl(String image)  async {
    var url= await FirebaseStorage.instance.ref().child(image).getDownloadURL();
    return url;
  }

  getdata() async {
    __picslist=[];
    notifyListeners();
    Firestore.instance
        .collection("pics")
        .orderBy("add_time",descending: true).limit(20)
        .getDocuments()
        .then((snapshort) {
      snapshort.documents.forEach((f)async {
       __picslist.add({"image":f.data["image"],"id":f.documentID});
      });
      notifyListeners();
    });
  }
  PicModel(){
    getdata();
  }

}