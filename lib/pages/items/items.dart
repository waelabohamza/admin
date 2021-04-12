import 'package:admin/components/searchglobal.dart';
import 'package:admin/pages/items/itemslist.dart';
import 'package:flutter/material.dart';
import 'package:admin/components/mydrawer.dart';
import 'package:admin/components/crud.dart';

class Items extends StatefulWidget {
  Items({Key key}) : super(key: key);

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  Crud crud = new Crud();

  Future deleteItem(String id, String imagename) async {
    var data = {"itemid": id, "imagename": imagename};
    await crud.writeData("deleteitems", data);
  }
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("الوجبات"),
             actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    showSearch(
                        context: context,
                        delegate: DataSearch(type: "items"   , mdw : mdw ));
                  })
            ]
          ),
          // drawer: MyDrawer(),
          floatingActionButton: Container(
              padding: EdgeInsets.only(left: mdw - 100),
              child: Container(
                  width: 80,
                  height: 80,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('additems');
                    },
                    child: Icon(
                      Icons.add,
                      size: 40,
                    ),
                    backgroundColor: Colors.red,
                  ))),
          body: WillPopScope(
              child: FutureBuilder(
                future: crud.readData("items"),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        // print(snapshot.data[i]['item_image']);
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            color: Colors.red,
                            child: Center(
                                child: Text("حذف نهائي",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white))),
                          ),
                          // secondaryBackground: Text("DELETE" , style: TextStyle(fontSize: 40 , color: Colors.black),),
                          child: ItemsList(
                            id: snapshot.data[i]['item_id'],
                            name: snapshot.data[i]['item_name'],
                            price: snapshot.data[i]['item_price'],
                            itemcat: snapshot.data[i]['cat_name'],
                            image: snapshot.data[i]['item_image'],
                            itemcatid: snapshot.data[i]['cat_id'],
                          ),
                          onDismissed: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              await deleteItem(snapshot.data[i]['item_id'],
                                  snapshot.data[i]['item_image']);
                                     setState(() {
                                    snapshot.data.removeAt(i);
                                  });                    
                            }
                          },
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              onWillPop: () {
                Navigator.of(context).pushNamed("home");
                return;
              }),
        ));
  }
}
