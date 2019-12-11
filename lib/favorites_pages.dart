import 'package:astropic_admin/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'grid_pics.dart';
import 'model/picsmodel.dart';

class FavoritesPages extends StatefulWidget {
  FavoritesPages({Key key}) : super(key: key);

  @override
  _FavoritesPagesState createState() => _FavoritesPagesState();
}

class _FavoritesPagesState extends State<FavoritesPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: Container(
        child:ScopedModelDescendant<PicModel>(
          rebuildOnChange: true,
          builder:(context,child,model){
            return  model.favoritelist.length==0 ? Center( child: Text("NO Images"),):  GridPics(favor: model.favoritelist,);
          },
        )
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}