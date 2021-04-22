import 'package:admin/components/alert.dart';
import 'package:admin/components/valid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:admin/components/mydrawer.dart';
import 'dart:io';
import 'package:admin/components/crud.dart';

class AddOffers extends StatefulWidget {
  AddOffers({Key key}) : super(key: key);
  @override
  _AddOffersState createState() => _AddOffersState();
}

class _AddOffersState extends State<AddOffers> {
  Crud crud = new Crud();

  GlobalKey<FormState> formdata = new GlobalKey<FormState>();
  File file;
  File myfile;
  var id;
  bool loading = false;

  String title;
  String body;

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

  addOffers() async {
    var formstate = formdata.currentState;
    if (formstate.validate()) {
      formstate.save();
      setState(() {
        loading = true;
      });
      if (file == null) return showdialogall(context, "خطأ", "يجب اضافة صورة ");
      if (loading == true) {
        showLoading(context);
      }
      await crud.addOffers(title, body, file);
      setState(() {
        loading = false;
      });
      Navigator.of(context).pushReplacementNamed("offers");
    } else {
      print("Not Valid");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("اضافة عرض"),
          ),
          drawer: MyDrawer(),
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
                          title = val;
                        },
                        validator: (val) {
                          return validInput(val, 3, 30, "يكون عنوان العرض ");
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.category),
                          labelText: "اكتب هنا عنوان العرض",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                        TextFormField(
                        onSaved: (val) {
                          body = val;
                        },
                        validator: (val) {
                          return validInput(val, 10, 150, "يكون محتوى العرض ");
                        },
                        minLines: 1,
                        maxLines: 2,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.category),
                          labelText: "اكتب هنا محتوى العرض",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Text("تكاسي")  ,
              Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: MaterialButton(
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
                child: MaterialButton(
                  child: Text("اضافة عرض",
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  color: Colors.red,
                  onPressed: addOffers,
                ),
              )
            ],
          ),
        ));
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
