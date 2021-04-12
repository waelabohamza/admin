import 'package:admin/pages/categories/categorieslist.dart';
import 'package:flutter/material.dart';
import 'package:admin/components/crud.dart';
 
class CatFood extends StatefulWidget {
  CatFood({Key key}) : super(key: key);

  @override
  _CatFoodState createState() => _CatFoodState();
}

class _CatFoodState extends State<CatFood> {
  Crud crud = new Crud();
  var b = 2;

  Future deleteCategory(String id, String imagename) async {
    var data = {"catid": id, "imagename": imagename};
    await crud.writeData("deletecategories", data);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mdw = MediaQuery.of(context).size.width;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: WillPopScope(
              child: FutureBuilder(
                future: crud.readData("catfood"),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: <Widget>[
                        // Container(
                        //     child: Image.asset("images/categories/3.png")),
                        for (int i = 0; i < snapshot.data.length; i++)
                          Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) async {
                                if (direction == DismissDirection.startToEnd) {
                                  await deleteCategory(
                                      snapshot.data[i]['cat_id'],
                                      snapshot.data[i]['cat_photo']);
                                  setState(() {
                                    snapshot.data.removeAt(i);
                                  });
                                }
                              },
                              background: Container(
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("حذف نهائي",
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white)),
                                ),
                              ),
                              child: CategoryList(
                                id: snapshot.data[i]['cat_id'],
                                image: snapshot.data[i]['cat_photo'],
                                name: snapshot.data[i]['cat_name'],
                                nameen: snapshot.data[i]['cat_name_en'],
                              ))
                      ],
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              onWillPop: () {
                Navigator.of(context).pushNamed("home");
                return;
              }),
        );
  }
}
