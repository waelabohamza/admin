import 'package:admin/components/valid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
// import "package:searchable_dropdown/searchable_dropdown.dart";
import 'package:dropdown_search/dropdownSearch.dart';
import 'package:admin/components/crud.dart';
import 'package:admin/components/mydrawer.dart';
import 'package:admin/components/alert.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditItem extends StatefulWidget {
  final itemid;
  final itemname;
  final itemprice;
  final itemcat;
  final item_catid;
  final image;
  EditItem(
      {this.itemid,
      this.itemname,
      this.itemcat,
      this.itemprice,
      this.item_catid,
      this.image});
  // EditItem({Key key  , this.id}) : super(key: key);

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  Crud crud = new Crud();

  File file;
  File myfile;

  GlobalKey<FormState> formdata = new GlobalKey<FormState>();

  var itemname;
  var itemprice;
  var itemsize;
  bool loading;

  List itemdetails = new List();

  String _catname = null;
  List<dynamic> _datadropdown = List();

  void _choosegallery() async {
    final myfile = await ImagePicker().getImage(source: ImageSource.gallery,
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

  var itemres;

  editItem() async {
    // assert(_catname != null) ;
    var formstate = formdata.currentState;
    if (formstate.validate()) {
      setState(() {
        loading = true;
      });

      formstate.save();
      // if (file == null) return showdialogall(context, "خطأ", "يجب اضافة صورة ");
      if (file != null) {
        if (_catname == null)
          return showdialogall(context, "خطأ", "يجب تحديد القسم");

        if (loading == true) {
          showLoading(context);
        }

        await crud.editItems(
            widget.itemid, itemname, itemprice, _catname, true, file);
      } else {
        if (_catname == null)
          return showdialogall(context, "خطأ", "يجب تحديد القسم");

        if (loading == true) {
          showLoading(context);
        }

        await crud.editItems(
            widget.itemid, itemname, itemprice, _catname, false);
      }
      setState(() {
        loading = false;
      });

      Navigator.of(context).pushReplacementNamed("items");
    } else {
      print("Not Valid");
    }
  }

  // Start DropDown Menu

  void getCatName() async {
    String url = "http://${crud.server_name}/categories/categories.php";

    final respose = await http.get(Uri.parse(url)); //untuk melakukan request ke webservice
    var listData = jsonDecode(respose.body); //lalu kita decode hasil datanya
    for (int i = 0; i < listData.length; i++)
      setState(() {
        _datadropdown.add(listData[i]['cat_name']);
      });
    // print("data : $listData");
  }

  // End
  @override
  void initState() {
    // TODO: implement initState
    _catname = widget.itemcat;
    getCatName();
    print(_catname);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Text('تعديل معلومات الوجبة'),
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
                          initialValue: widget.itemname,
                          onSaved: (val) {
                            itemname = val;
                          },
                          validator: (val) {
                          return validInput(val, 3, 30 , "يكون اسم الوجبة ")  ;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.fastfood),
                            labelText: "اكتب هنا اسم الوجبة",
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        TextFormField(
                          initialValue: widget.itemprice,
                          onSaved: (val) {
                            itemprice = val;
                          },
                          validator: (val) {
                            return validInput(val, 0, 6 , "يكون السعر ")  ;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.attach_money),
                            labelText: "اكتب هنا السعر  ",
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        Container(
                            color: Colors.white,
                            child: DropdownSearch(
                              items: _datadropdown,
                              label: "اختر هنا اسم القسم",
                              onChanged: (val) {
                                _catname = val;
                                print(_catname);
                              },
                              selectedItem: widget.itemcat,
                            ))
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: RaisedButton(
                    child: Text(" تعديل الصورة",
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    color: Colors.red,
                    onPressed: showbottommenu,
                  ),
                ),
                Container(
                    width: 200,
                    height: 200,
                    child: file == null
                        ? CachedNetworkImage(
                            imageUrl:
                                "http://${crud.server_name}/upload/items/${widget.image}",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            height: 100,
                            width: 200,
                            fit: BoxFit.cover,
                          )
                        : Image.file(file)),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: RaisedButton(
                    child: Text("تعديل",
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    color: Colors.red,
                    onPressed: editItem,
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
