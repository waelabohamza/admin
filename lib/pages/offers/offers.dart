import 'package:admin/pages/offers/offerslist.dart';
import 'package:flutter/material.dart';
import 'package:admin/components/mydrawer.dart';
import 'package:admin/components/crud.dart';

class Offers extends StatefulWidget {
  Offers({Key key}) : super(key: key);
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers>{
  Crud crud = new Crud();
  Future deleteOffers(String id, String imagename) async {
    var data = {"offerid": id, "imagename": imagename};
    await crud.writeData("deleteoffers", data);
  }
  
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: Text("العروض"), actions:[
            // IconButton(
            //     icon: Icon(Icons.search),
            //     onPressed: () async {
            //       showSearch(
            //           context: context,
            //           delegate: DataSearch(type: "items", mdw: mdw));
            //     })
          ]),
          // drawer: MyDrawer(),
          floatingActionButton: Container(
              padding: EdgeInsets.only(left: mdw - 100),
              child: Container(
                  width: 80,
                  height: 80,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('addoffers');
                    },
                    child: Icon(
                      Icons.add,
                      size: 40,
                    ),
                    backgroundColor: Colors.red,
                  ))),
          body: WillPopScope(
              child: FutureBuilder(
                future: crud.readData("offers"),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData){
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
                          child: OffersList(
                            list: snapshot.data[i],
                            servername: crud.server_name,
                          ),
                          onDismissed: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              await deleteOffers(snapshot.data[i]['offers_id'],
                                  snapshot.data[i]['offers_image']);
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
