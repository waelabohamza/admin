import 'package:admin/components/searchglobal.dart';
 
import 'package:admin/pages/users/userslist.dart';
import 'package:flutter/material.dart';
import 'package:admin/components/crud.dart';


class Users extends StatefulWidget {
  Users({Key key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  Crud crud = new Crud();
  deleteUsers(id, image) async {
    var data = {"userid": id, "userimage": image};
    await crud.writeData("deleteusers", data);
  }
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('الاعضاء'),
             actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    showSearch(
                        context: context,
                        delegate: DataSearch(type: "users"   , mdw : mdw ));
                  })
            ]
          ),
          floatingActionButton: Container(
              padding: EdgeInsets.only(left: mdw - 100),
              child: Container(
                  width: 80,
                  height: 80,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('addusers');
                    },
                    child: Icon(
                      Icons.add,
                      size: 40,
                    ),
                    backgroundColor: Colors.red,
                  ))),
          body: WillPopScope(
              child: FutureBuilder(
                future: crud.readData("users"),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) async {
                            await deleteUsers(snapshot.data[i]['user_id'],
                                snapshot.data[i]['user_image']);
                            setState(() {
                              snapshot.data.removeAt(i);
                            });
                          },
                          background: Container(
                            color: Colors.red,
                            child: Center(
                                child: Text("حذف نهائي",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white))),
                          ),
                          direction: DismissDirection.startToEnd,
                          child: UsersList(listusers: snapshot.data[i]),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              onWillPop: () {
                Navigator.of(context).pushReplacementNamed("home");
              }),
        ));
  }
}
