import 'package:admin/components/alert.dart';
import 'package:admin/components/valid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:admin/components/mydrawer.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:admin/components/crud.dart';

class EditCategories extends StatefulWidget {
  final catname;
  final catnameen;
  final catid;
  final catimage;

  EditCategories({this.catid, this.catimage, this.catname, this.catnameen});

  @override
  _EditCategoriesState createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {
  Crud crud = new Crud();

  GlobalKey<FormState> formdata = new GlobalKey<FormState>();
  File file;
  File myfile;
  var id;
  bool loading = false;

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

  var categoryname, categorynameen;

  editCategory() async {
    var formstate = formdata.currentState;
    if (formstate.validate()) {
      setState(() {
        loading = true;
      });
      formstate.save();
      if (file != null) {
        if (loading == true) {
          showLoading(context);
        }
        await crud.editCategories(
            widget.catid, categoryname, categorynameen, true, file);
      } else {
        if (loading == true) {
          showLoading(context);
        }
        await crud.editCategories(
            widget.catid, categoryname, categorynameen, false);
      }
      setState(() {
        loading = false;
      });
      Navigator.of(context).pushReplacementNamed("choosecat");
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
            title: Text("تعديل قسم"),
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
                        initialValue: widget.catname,
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
                        initialValue: widget.catnameen,
                        onSaved: (val) {
                          categorynameen = val;
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
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: RaisedButton(
                  child: Text(" تعدل الصورة",
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  color: Colors.red,
                  onPressed: showbottommenu,
                ),
              ),
              Container(
                  width: 200,
                  height: 300,
                  child: file == null
                      ? CachedNetworkImage(
                          imageUrl:
                              "http://${crud.server_name}/upload/categories/${widget.catimage}",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          height: 200,
                          width: 100,
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                      : Image.file(file)),
              Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: RaisedButton(
                  child: Text("تحديث",
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  color: Colors.red,
                  onPressed: editCategory,
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
                  title: Text("   Upload From Gallery",
                      style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          );
        });
  }
}
