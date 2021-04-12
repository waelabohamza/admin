
import 'package:admin/components/searchglobal.dart';
import 'package:admin/pages/taxi/component/alertform.dart';
import 'package:admin/pages/taxi/taxilist.dart';
import 'package:flutter/material.dart';
import 'package:admin/components/crud.dart';

class Taxi extends StatefulWidget {
  Taxi({Key key}) : super(key: key);
  @override
  _TaxiState createState() => _TaxiState();
}
class _TaxiState extends State<Taxi> {
    TextEditingController initialPrice = new TextEditingController(); 
    TextEditingController priceKm = new TextEditingController(); 



  Crud crud = new Crud();
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                    bottom: TabBar(
                        labelStyle: TextStyle(fontSize: 20),
                        tabs: [Text("النشطة"), Text("بانتظار الموافقة")]),
                    title: Text('التكاسي'),
                    actions: [
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () async {
                            showSearch(
                                context: context,
                                delegate:
                                    DataSearch(type: "taxi", mdw: mdw));
                          })
                    ]),
                floatingActionButton: Container(
                    padding: EdgeInsets.only(left: mdw - 80),
                    child: Container(
                        width: 60,
                        height: 60,
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('addtaxi');
                          },
                          child: Icon(
                            Icons.add,
                            size: 30,
                          ),
                          backgroundColor: Colors.red,
                        ))),
                body: WillPopScope(
                    child: TabBarView(children: [
                      FutureBuilder(
                        future: crud.readDataWhere('taxi', "1"),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {  
                          if (snapshot.hasData) {
                            if (snapshot.data[0] == "faild") {
                              return Text("لا يوجد اي تكاسي بحاجة الموافقة");
                            } else {
                              return TaxiApprove(
                                taxiapprove: snapshot.data,
                                crud: crud,
                              );
                            }
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                      FutureBuilder(
                        future: crud.readDataWhere('taxi', "0"),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data[0] == "faild") {
                              return Text("لا يوجد اي تكاسي بحاجة الموافقة");
                            } else {
                              return TaxiNotApprove(
                                  taxinotapprove: snapshot.data  ,
                                  crud: crud
                                  );
                            }
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ]),
                    onWillPop: () {
                      Navigator.of(context).pushReplacementNamed("home");
                    }))));
  }
}
class TaxiNotApprove extends StatelessWidget {
 
  final crud ; 
  final taxinotapprove;
  TaxiNotApprove({this.taxinotapprove , this.crud });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: taxinotapprove.length,
          itemBuilder: (context, i) {
            return Dismissible(
              key: UniqueKey(),
              child: TaxiList(
                taxilist: taxinotapprove[i],
                crud: crud,
              ),
              background: Container(
                padding: EdgeInsets.all(10),
                color: Colors.red,
                child: Text(
                  "حذف نهائي",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              secondaryBackground: Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                child: Text(
                  "موافقة",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              onDismissed: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  var data = {
                    "id": taxinotapprove[i]['taxi_id'].toString(),
                    "image": taxinotapprove[i]['taxi_image'].toString(),
                    "licence": taxinotapprove[i]['taxi_licence'].toString()
                  };
                  await crud.writeData("deletetaxi", data);
                }
                if (direction == DismissDirection.endToStart) {
                  // var data = {"id": taxinotapprove[i]['taxi_id'].toString()};
                  // await crud.writeData("taxipprove", data);
                  showdialogallApproveTaxi(context ,taxinotapprove[i]['taxi_id'].toString()) ; 
                }
              },
            );
          }),
    );
  }
}
class TaxiApprove extends StatelessWidget {
  final taxiapprove;
  final crud;
  TaxiApprove({this.taxiapprove, this.crud});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: taxiapprove.length,
          itemBuilder: (context, i) {
            return Dismissible(
              key: UniqueKey(),
              child: TaxiList(
                taxilist: taxiapprove[i],
                crud: crud,
              ),
              background: Container(
                padding: EdgeInsets.all(10),
                color: Colors.red,
                child: Text(
                  "حذف نهائي",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              secondaryBackground: Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                child: Text(
                  "موافقة",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  var data = {
                    "id": taxiapprove[i]['taxi_id'].toString(),
                    "image": taxiapprove[i]['taxi_image'].toString(),
                    "licence": taxiapprove[i]['taxi_licence'].toString()
                  };
                  await crud.writeData("deletetaxi", data);
                  taxiapprove.removeAt(i);
                }
              },
            );
          }),
    );
  }
}
