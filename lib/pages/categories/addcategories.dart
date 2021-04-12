import 'package:admin/components/alert.dart';
import 'package:admin/components/valid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:admin/components/mydrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:admin/components/crud.dart';

class AddCategories extends StatefulWidget {
  AddCategories({Key key}) : super(key: key);
  @override
  _AddCategoriesState createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  Crud crud = new Crud();

  GlobalKey<FormState> formdata = new GlobalKey<FormState>();
  File file;
  File myfile;
  var id;
  bool loading = false;

  int selectedRadio;

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

  var categoryname ,categorynameen ;

  addCategory() async {
    var formstate = formdata.currentState;
    if (formstate.validate()) {
      formstate.save();

      setState(() {
        loading = true;
      });
        if (selectedRadio == null || selectedRadio == 11)
        return showdialogall(context, "خطأ", "يجب اختيار القسم ");
      if (file == null) return showdialogall(context, "خطأ", "يجب اضافة صورة ");
     

      if (loading == true) {
        showLoading(context);
      }
      await crud.addCategories(categoryname   , categorynameen  , selectedRadio , file);
      setState(() {
        loading = false;
      });
      Navigator.of(context).pushReplacementNamed("choosecat");
    } else {
      print("Not Valid");
    }
  }
  getAllpref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id');
    });
  }
  @override
  void initState() {
    super.initState();
    getAllpref();
    selectedRadio = 11;
  }
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      print(selectedRadio) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("اضافة قسم"),
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
                          categoryname = val;
                        },
                        validator: (val) {
                          return validInput(val, 3, 30, "يكون اسم القسم ");
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.category),
                          labelText: "اكتب هنا اسم القسم",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                        TextFormField(
                        onSaved: (val) {
                          categorynameen = val;
                        },
                        validator: (val) {
                          return validInput(val, 3, 30, "يكون اسم القسم ");
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.category),
                          labelText: "اكتب هنا اسم القسم باللغة الانكليزية",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),           
                  // Text("تكاسي")  ,
                  RadioListTile(
                   title: Text("تكاسي"),
                    value: 1,
                    groupValue: selectedRadio,
                    activeColor: Colors.green,
                    onChanged: (val) {
                      // print("Radio $val");
                      setSelectedRadio(val);
                    },
                  ),
                  RadioListTile(
                    title: Text("طعام"),
                    value: 0,
                    groupValue: selectedRadio,
                    activeColor: Colors.blue,
                    onChanged: (val) {
                      // print("Radio $val");
                      setSelectedRadio(val);
                    },
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
                  child: Text("اضافة قسم",
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  color: Colors.red,
                  onPressed: addCategory,
                ),
              )
            ],
          ),
        ));
  }

  showbottommenu(){
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
                  title: Text("Take Photo", style: TextStyle(fontSize: 20)),
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
