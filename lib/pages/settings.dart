import 'package:flutter/material.dart';
// my import
import 'package:admin/components/crud.dart';
import 'package:provider/provider.dart';
import 'package:admin/common.dart';
import 'package:admin/components/valid.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Crud crud = new Crud();
  bool showpassword = true;
  String username, password, email;

  GlobalKey<FormState> settings = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Custom Route From Drawer For get id Admin
    Map routs = ModalRoute.of(context).settings.arguments;

    updateSettings() async {
      var formdata = settings.currentState;
      if (formdata.validate()) {
        formdata.save();
        var data  = {"id" : routs['id'] , "username" : username , "password" : password , "email" : email} ; 
        await crud.writeData("editsettings", data);
        Navigator.of(context).pushNamed("home"); 
      } else {
        print("not valid");
      }
    }

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('الاعدادات'),
          ),
          body: FutureBuilder(
            future: crud.readDataWhere("settings", routs['id']),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Form(
                        key: settings,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              initialValue: snapshot.data['username'],
                              onSaved: (val) {
                                username = val;
                              },
                              validator: (val) {
                                return validInput(
                                    val, 4, 20, "يكون اسم المستخدم");
                              },
                              decoration: InputDecoration(hintText: "الاسم"),
                            ),
                            Consumer<Common>(
                              builder: (context, common, child) {
                                return TextFormField(
                                  obscureText: common.showpass,
                                  initialValue: snapshot.data['password'],
                                  validator: (val) {
                                    return validInput(
                                        val, 4, 20, "تكون كلمة المرور");
                                  },
                                  onSaved: (val) {
                                    password = val;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "الاسم",
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.remove_red_eye),
                                        onPressed: () {
                                          common.changeShowPass();
                                        },
                                      )),
                                );
                              },
                            ),
                            TextFormField(
                              initialValue: snapshot.data['email'],
                              onSaved: (val) {
                                email = val;
                              },
                              validator: (val) {
                                return validInput(val, 4, 20,
                                    " يكون البريد الالكتروني ", "email");
                              },
                              decoration: InputDecoration(hintText: "الاسم"),
                            ),
                            RaisedButton(
                              color: Colors.blue,
                              child: Text(
                                "تحديث",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: updateSettings,
                            )
                          ],
                        ))
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
