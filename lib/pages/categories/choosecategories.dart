import 'package:admin/components/searchglobal.dart';
import 'package:admin/pages/categories/catfood.dart';
import 'package:admin/pages/categories/cattaxi.dart';
import 'package:flutter/material.dart';

class ChooseCat extends StatefulWidget {
  ChooseCat({Key key}) : super(key: key);
  @override
  _ChooseCatState createState() => _ChooseCatState();
}

class _ChooseCatState extends State<ChooseCat> {
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
                floatingActionButton: Container(
              padding: EdgeInsets.only(left: mdw - 100),
              child: Container(
                  width: 60,
                  height: 60,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('addcategories');
                    },
                    child: Icon(
                      Icons.add,
                      size: 25,
                    ),
                    backgroundColor: Colors.red,
                  ))) , 
                appBar: AppBar(
                    bottom: TabBar(
                        labelStyle: TextStyle(fontSize: 20),
                        tabs: [Text("طعام"), Text("تكاسي")]),
                    title: Text('الاقسام'),
                    actions: [
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () async {
                            showSearch(
                                context: context,
                                delegate:
                                    DataSearch(type: "categories", mdw: mdw));
                          })
                    ]),
                body: TabBarView(
                  children: [
                    CatFood(),
                    CatTaxi()
                  ],
                ))));
  }
}
