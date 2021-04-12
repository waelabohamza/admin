import 'dart:io';
import 'package:admin/components/getnotify.dart';
import 'package:flutter/material.dart';
import '../components/crud.dart';
import '../components/mydrawer.dart';
import 'package:admin/common.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Crud crud = new Crud();
  var counts;
  bool loading = true ;

  Common common = new Common();

  getcountall() async {
    counts = await crud.readData("countall");
    setState(() {
      loading = false;
    });
    print(counts);
  }

  @override
  void initState() {
    getcountall();
    // requestPermissons();
    // getNotify(context);
    // getLocalNotification();
    // requestLocalPermissions();
    super.initState();
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                //  onPressed: () =>   Navigator.of(context).pop(true)  ,
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    double mdw = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            key: _scaffoldKey,
            drawer: new MyDrawer(),
            // appBar: AppBar(
            //   title: Text('لوحة القيادة'),
            // ),
            // drawer: MyDrawer(),
            body: WillPopScope(
                child: loading == true
                    ? Center(child: CircularProgressIndicator())
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          Stack(
                            children: [
                              buildTopRaduis(mdw),
                              buildTopText(mdw),
                              Container(
                                margin: EdgeInsets.only(top: 200),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("restaurants");
                                            },
                                            child: Container(
                                              height: 220,
                                              child: Card(
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/home/restauarnts.png",
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Text(
                                                      "المطاعم",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                    Text(
                                                      counts['res'],
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("users");
                                            },
                                            child: Container(
                                              height: 220,
                                              child: Card(
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/home/users.png",
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Text(
                                                      "المستخدمين",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                    Text(
                                                      counts['users'],
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("choosecat");
                                            },
                                            child: Container(
                                              height: 220,
                                              child: Card(
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/home/categories.png",
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Text(
                                                      "الاقسام",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                    Text(
                                                      counts['cats'],
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("items");
                                            },
                                            child: Container(
                                              height: 220,
                                              child: Card(
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/home/food.png",
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Text(
                                                      "الوجبات",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                    Text(
                                                      counts['items'],
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("chooseorders");
                                            },
                                            child: Container(
                                              height: 220,
                                              child: Card(
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/home/orders.png",
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Text(
                                                      "الطلبات",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                    Text(
                                                      "",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("sendmoney");
                                            },
                                            child: Container(
                                              height: 220,
                                              child: Card(
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/home/transfermoney.png",
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Text(
                                                      "تحويل رصيد",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                    Text(
                                                      "",
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushReplacementNamed("taxi");
                                            },
                                            child: Container(
                                              height: 220,
                                              child: Card(
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/home/taxi.png",
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Text(
                                                      "التكاسي",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                    Text(
                                                      " ",
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                  "choosecatmessage");
                                            },
                                            child: Container(
                                              height: 220,
                                              child: Card(
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/home/message.png",
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Text(
                                                      "رسائل",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                    Text(
                                                      " ",
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("offers");
                                            },
                                            child: Container(
                                              height: 220,
                                              child: Card(
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/home/offer.png",
                                                      width: 100,
                                                      height: 90,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    Text(
                                                      "العروض",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                    Text(
                                                      " ",
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed("editimages"); 
                                            },
                                            child: Container(
                                              height: 220,
                                              child: Card(
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/home/editimages.png",
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Text(
                                                      "الصور",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                    Text(
                                                      " ",
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                onWillPop: _onWillPop)));
  }

  Transform buildTopRaduis(mdw) {
    return Transform.scale(
        scale: 2,
        child: Transform.translate(
          offset: Offset(0, -200),
          child: Container(
            height: mdw,
            width: mdw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(mdw)),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.green, Colors.blue]),
            ),
          ),
        ));
  }
  Padding buildTopText(mdw) {
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  }),
              Expanded(child: Container()),
              Text("  TalabPay  ",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
          Text("لوحة القيادة",
              style: TextStyle(color: Colors.white, fontSize: 30)),
        ],
      ),
    );
  }
}
