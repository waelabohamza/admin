import 'package:admin/components/searchglobal.dart';
import 'package:flutter/material.dart';
import 'package:admin/components/crud.dart';
import 'package:admin/pages/restaurants/restaurantslist.dart';

class Restaurants extends StatefulWidget {
  Restaurants({Key key}) : super(key: key);
  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
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
                  title: Text('المطاعم'),
                   actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    showSearch(
                        context: context,
                        delegate: DataSearch(type: "restuarants"   , mdw : mdw ));
                  })
            ]
                ),
                floatingActionButton: Container(
                    padding: EdgeInsets.only(left: mdw - 80),
                    child: Container(
                        width: 60,
                        height: 60,
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('addrestaurants');
                          },
                          child: Icon(
                            Icons.add,
                            size: 30,
                          ),
                          backgroundColor: Colors.red,
                        ))),
                body: WillPopScope(child: TabBarView(children: [
                  FutureBuilder(
                    future: crud.readDataWhere('restaurants', "1"),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data[0] == "faild") {
                          return Text("لا يوجد اي مطاعم بحاجة الموافقة");
                        } else {
                          return RestaurantsApprove(
                            resturantsapprove: snapshot.data,
                          );
                        }
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                  FutureBuilder(
                    future: crud.readDataWhere('restaurants', "0"),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data[0] == "faild") {
                          return Text("لا يوجد اي مطاعم بحاجة الموافقة");
                        } else {
                          return RestaurantsNotApprove(
                              restaurantsnotapprove: snapshot.data);
                        }
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ]), onWillPop: (){
                    Navigator.of(context).pushReplacementNamed("home") ; 
                })
                )
                ));
  }
}

class RestaurantsNotApprove extends StatelessWidget {
  Crud crud = new Crud();

  final restaurantsnotapprove;

  var resault;


  RestaurantsNotApprove({this.restaurantsnotapprove});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: restaurantsnotapprove.length,
          itemBuilder: (context, i) {
            return Dismissible(
              key: UniqueKey(),
              child: RestaurantsList(
                restaurantslist: restaurantsnotapprove[i],
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
                    "resid": restaurantsnotapprove[i]['res_id'].toString(),
                    "reslogo": restaurantsnotapprove[i]['res_image'].toString(),
                    "reslisence":
                        restaurantsnotapprove[i]['res_lisence'].toString()
                  };

                  await crud.writeData("restaurantsdelete", data);
                  
         

                }

                if (direction == DismissDirection.endToStart) {
                  var data = {
                    "resid": restaurantsnotapprove[i]['res_id'].toString()
                  };
                  await crud.writeData("restaurantsapprove", data);
                 

                }
              },
            );
          }),
    );
  }
}

class RestaurantsApprove extends StatelessWidget   {
  final resturantsapprove;

  RestaurantsApprove({this.resturantsapprove});
  Crud crud = new Crud();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: resturantsapprove.length,
          itemBuilder: (context, i) {
            return Dismissible(
              key: UniqueKey(),
              child: RestaurantsList(
              restaurantslist:resturantsapprove[i] , 
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
                    "resid": resturantsapprove[i]['res_id'].toString(),
                    "reslogo": resturantsapprove[i]['res_image'].toString(),
                    "reslisence": resturantsapprove[i]['res_lisence'].toString()
                  };
                  await crud.writeData("restaurantsdelete", data);
                   resturantsapprove.removeAt(i) ; 
                }
              },
            );
          }),
    );
  }
}
