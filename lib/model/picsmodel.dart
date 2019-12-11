import 'dart:math';

import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PicModel extends Model {

  List<Map<String, dynamic>> __picslist = [];

  List<Map<String, dynamic>> get picsist => __picslist;

  List<String> _favorites = [];

  List<String> get favoritelist => _favorites;

  String storekey="fav";

  geturl(String image) async {
    var url =
        await FirebaseStorage.instance.ref().child(image).getDownloadURL();
    return url;
  }

  getdata() async {
    __picslist = [];
    notifyListeners();
    Firestore.instance
        .collection("pics")
        .orderBy("add_time", descending: true)
        .limit(20)
        .getDocuments()
        .then((snapshort) {
      snapshort.documents.forEach((f) async {
        __picslist.add({"image": f.data["image"], "id": f.documentID});
      });
      notifyListeners();
    });
  }
  adddata(index){
    print("'gatting data .............");
    Firestore.instance
        .collection("pics")
        .orderBy("add_time", descending: true)
        .getDocuments()
        .then((snapshort) {
      snapshort.documents.forEach((f) async {
        __picslist.add({"image": f.data["image"], "id": f.documentID});
      });
      notifyListeners();
    });

  }

  PicModel() {
    print("model running.......");
    getdata();
    getfavorites();

  }

  setfavorite(image) async {
    final prefs = await SharedPreferences.getInstance();
    var mystring= prefs.getStringList(storekey);
    if (mystring!=null) {
      mystring.add(image);
      _favorites=mystring;
    }  else{
      mystring=[image,];
      _favorites=mystring;
    }
    notifyListeners();
    prefs.setStringList(storekey, mystring);
  }

  removefavorites(image) async{
    final prefs = await SharedPreferences.getInstance();
    var mystring= prefs.getStringList(storekey);
    if (mystring!=null) {
      mystring.remove(image);
      _favorites=mystring;
    }
    notifyListeners();
    prefs.setStringList(storekey, mystring);
  }

  bool chackfavorites(image) {
    return  _favorites.contains(image);
  }

  getfavorites()async{
    final prefs = await SharedPreferences.getInstance();
    final  mystring=  prefs.getStringList(storekey);
    if (mystring!=null) {
      _favorites=mystring;
      notifyListeners();
    }
  }

}
