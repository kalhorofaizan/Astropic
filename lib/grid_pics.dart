import 'package:flutter/material.dart';
import 'imageshow.dart';

class GridPics extends StatefulWidget {
  List<Map<dynamic,dynamic>> pics;
  List<String> favor;
  GridPics({this.pics,this.favor,Key key}) : super(key: key);

  @override
  _GridPicsState createState() => _GridPicsState();
}

class _GridPicsState extends State<GridPics> {

  @override
  Widget build(BuildContext context) {


    return GridView.builder(
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2/3),
      itemCount: widget.pics!=null?  widget.pics.length :widget.favor.length ,
      padding: EdgeInsets.all(5),
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
            child: widget.pics!=null ? Imageshow(widget.pics[index]['image'],id:  widget.pics[index]['id']):  Imageshow(widget.favor[index])) ;
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}