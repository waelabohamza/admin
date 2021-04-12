import 'package:admin/components/crud.dart';
import 'package:admin/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var username;
  var email;
  var id;
  bool isSignIn = false;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    username = preferences.getString("username");
    email = preferences.getString("email");
    id = preferences.getString("id");

    if (username != null) {
      setState(() {
        username = preferences.getString("username");
        email = preferences.getString("email");
        isSignIn = true;
      });
    }
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: isSignIn ? Text(email) : Text(""),
          accountName: isSignIn ? Text(username) : Text(""),
          currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
          decoration: BoxDecoration(
            color: Colors.blue,

            // image: DecorationImage(
            //     image: NetworkImage("https://s.hdnux.com/photos/01/01/50/56/17206204/3/rawImage.jpg"), fit: BoxFit.cover)
          ),
        ),
        ListTile(
          title: Text(
            "الصفحة الرئيسية",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          leading: Icon(
            Icons.home,
            color: Colors.blue,
            size: 25,
          ),
          onTap: () {
            Navigator.of(context).pushNamed('home');
          },
        ),
        ListTile(
          title: Text("المطاعم ",
              style: TextStyle(color: Colors.black, fontSize: 18)),
          leading: Icon(
            Icons.restaurant,
            color: Colors.blue,
            size: 25,
          ),
          onTap: () {
            Navigator.of(context).pushNamed('restaurants');
          },
        ),

        ListTile(
          title: Text(" الاقسام ",
              style: TextStyle(color: Colors.black, fontSize: 18)),
          leading: Icon(
            Icons.category,
            color: Colors.blue,
            size: 25,
          ),
          onTap: () {
            Navigator.of(context).pushNamed('choosecat');
          },
        ),
        ListTile(
          title: Text("اضافة فسم",
              style: TextStyle(color: Colors.black, fontSize: 18)),
          leading: Icon(
            Icons.add_box,
            color: Colors.blue,
            size: 25,
          ),
          onTap: () {
            Navigator.of(context).pushNamed("addcategories");
          },
        ),
        ListTile(
          title: Text("الوجبات",
              style: TextStyle(color: Colors.black, fontSize: 18)),
          leading: Icon(
            Icons.fastfood,
            color: Colors.blue,
            size: 25,
          ),
          onTap: () {
            Navigator.of(context).pushNamed("items");
          },
        ),
        ListTile(
          title: Text("اضافة وجبة",
              style: TextStyle(color: Colors.black, fontSize: 18)),
          leading: Icon(
            Icons.add_box,
            color: Colors.blue,
            size: 25,
          ),
          onTap: () {
            Navigator.of(context).pushNamed("additems");
          },
        ),
        // ExpansionTile(
        //   leading: Icon(
        //     Icons.category,
        //     color: Colors.blue,
        //     size: 25,
        //   ),
        //   title: Text("انواع الجوالات" ,  style: TextStyle(color: Colors.black, fontSize: 18)),
        //   children: <Widget>[
        //      Container( padding: EdgeInsets.all(10) , color:Colors.red , width: 400 , child: Text("Wael"),)
        //   ],
        // ),
        Divider(color: Colors.blue),
        ListTile(
          title: Text(" حول التطبيق  ",
              style: TextStyle(color: Colors.black, fontSize: 18)),
          leading: Icon(
            Icons.info,
            color: Colors.blue,
            size: 25,
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text("الاعدادات",
              style: TextStyle(color: Colors.black, fontSize: 18)),
          leading: Icon(
            Icons.settings,
            color: Colors.blue,
            size: 25,
          ),
          onTap: () {
            Navigator.of(context).pushNamed("settings", arguments: {"id": id});
          },
        ),

        ListTile(
          title: Text("تسجيل الخروج",
              style: TextStyle(color: Colors.black, fontSize: 18)),
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.blue,
            size: 25,
          ),
          onTap: () async {
            var userid = sharedPrefs.getString("id");
            var token = sharedPrefs.getString("token");
            var data = {"userid": userid, "usertoken": token};
            await Crud().writeData("logout", data);
            sharedPrefs.clear();
            Navigator.of(context).pushReplacementNamed("login");
          },
        )
      ],
    ));
  }
}
