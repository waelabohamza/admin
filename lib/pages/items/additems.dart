import 'package:admin/components/valid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
// import "package:searchable_dropdown/searchable_dropdown.dart";
import 'package:dropdown_search/dropdownSearch.dart';
import 'package:admin/components/crud.dart';
import 'package:admin/components/mydrawer.dart';
import 'package:admin/components/alert.dart';

class AddItem extends StatefulWidget {
  AddItem({Key key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  Crud crud = new Crud();

  File file;
  File myfile;

  GlobalKey<FormState> formdata = new GlobalKey<FormState>();

  var itemname;
  var itemprice;
  var itemsize;
  bool loading;

  String _catname = null;
  String _resname = null;
  List<dynamic> _datadropdown = new List();
  List<dynamic> _datadropdowntwo = new List();

  void _choosegallery() async {
    final myfile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500.0,
        maxWidth: 500.0);
    // For Show Image Direct in Page Current witout Reload Page
    if (myfile != null)
      setState(() {
        file = File(myfile.path);
      });
    else {}
  }

  void _choosecamera() async {
    final myfile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 500.0,
        maxWidth: 500.0);
    // For Show Image Direct in Page Current witout Reload Page
    if (myfile != null)
      setState(() {
        file = File(myfile.path);
      });
    else {}
  }

  addItem() async {
    // assert(_catname != null) ;
    var formstate = formdata.currentState;
    if (formstate.validate()) {
      setState(() {
        loading = true;
      });

      formstate.save();
      if (file == null) {
        return showdialogall(context, "خطأ", "يجب اضافة صورة ");
      }

      if (_catname == null) {
        return showdialogall(context, "خطأ", "يجب تحديد القسم");
      }
      if (_resname == null) {
        return showdialogall(context, "خطأ", "يجب تحديد المطعم");
      }
      if (loading == true) {
        showLoading(context);
      }

      await crud.addItems(itemname, itemprice, _catname, _resname, file);
      setState(() {
        loading = false;
      });
      // print(response.body)
      Navigator.of(context).pushReplacementNamed("items");
    } else {
      print("Not Valid");
    }
  }

  // Start DropDown Menu

  void getCatName() async {
    print("====================") ; 
    var listData = await crud.readData("catfood");
    print("====================") ; 

    for (int i = 0; i < listData.length; i++)
      setState((){
        _datadropdown.add(listData[i]['cat_name']);
      });
  }

  void getResName() async {
    var listData = await crud.readData("restaurants");
    for (int i = 0; i < listData.length; i++)
      setState(() {
        _datadropdowntwo.add(listData[i]['res_name']);
      });
    print("data : $listData");
  }

  // End
  @override
  void initState() {
 
    getCatName();
    getResName();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Text('اضافة وجبة'),
            ),
            // drawer: MyDrawer(),
            body: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Form(
                    key: formdata,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          onSaved: (val) {
                            itemname = val;
                          },
                          validator: (val) {
                            return validInput(val, 3, 30, "يكون اسم الوجبة ");
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.fastfood),
                            labelText: "اكتب هنا اسم الوجبة",
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        TextFormField(
                          onSaved: (val) {
                            itemprice = val;
                          },
                          validator: (val) {
                            return validInput(val, 0, 6, "يكون السعر ");
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.attach_money),
                            labelText: "اكتب هنا السعر  ",
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        DropdownSearch(
                          items: _datadropdown,
                          label: "اختر هنا اسم القسم",
                          
                          onChanged: (val) {
                            _catname = val;
                          },
                          selectedItem: "اسم القسم",
                        ),
                        DropdownSearch(
                          items: _datadropdowntwo,
                          label: "اختر هنا اسم المطعم",
                          onChanged: (val) {
                            _resname = val;
                          },
                          selectedItem: "اسم المطعم",
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: RaisedButton(
                    child: Text(" اضف الصورة",
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    color: Colors.red,
                    onPressed: showbottommenu,
                  ),
                ),
                Container(
                    width: 200,
                    height: 200,
                    child: file == null
                        ? Center(child: Text(" لم يتم اختيار صورة "))
                        : Image.file(file)),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: RaisedButton(
                    child: Text("اضافة وجبة",
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    color: Colors.red,
                    onPressed: addItem,
                  ),
                )
              ],
            )));
  }

  showbottommenu() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(10),
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "Chooser Photo",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                ListTile(
                  onTap: () {
                    _choosecamera();
                    Navigator.of(context).pop();
                  },
                  leading: Icon(
                    Icons.camera_alt,
                    size: 40,
                  ),
                  title: Text("   Take Photo", style: TextStyle(fontSize: 20)),
                ),
                ListTile(
                  onTap: () {
                    _choosegallery();
                    Navigator.of(context).pop();
                  },
                  leading: Icon(
                    Icons.image,
                    size: 40,
                  ),
                  title: Text("Upload From Gallery",
                      style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          );
        });
  }
}
