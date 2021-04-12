import 'package:admin/components/alert.dart';
import 'package:admin/components/crud.dart';
import 'package:admin/components/valid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import "package:searchable_dropdown/searchable_dropdown.dart";
import 'package:dropdown_search/dropdownSearch.dart';
 

class AddTaxiTwo extends StatefulWidget {
  final email;
  AddTaxiTwo({Key key, this.email}) : super(key: key);

  @override
  _AddTaxiTwoState createState() => _AddTaxiTwoState();
}

class _AddTaxiTwoState extends State<AddTaxiTwo> {
  Crud crud = new Crud();

  File file;
  File file2;

  GlobalKey<FormState> formdata = new GlobalKey<FormState>();

  var taxiModel;
  var taxiYear;
  var taxiBrand;
  var taxiDescription = "aaaaaaaaaaa";
  var taxiImage;
  var taxiPrice;

  // var itemname;
  // var itemprice;
  // var itemsize;
  bool loading;

   

  List<dynamic> _datadropdown = List();
 

  // Start Uploaded Images

  void _choosegallery(String type) async {
    final myfile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 700.0,
        maxWidth: 700.0);
    // For Show Image Direct in Page Current witout Reload Page
    if (type == "image") {
      if (myfile != null) {
        setState(() {
          file = File(myfile.path);
        });
      }
    }
    if (type == "licence") {
      if (myfile != null) {
        setState(() {
          file2 = File(myfile.path);
        });
      }
    }
  }

  void _choosecamera(String type) async {
    final myfile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxHeight: 700.0,
        maxWidth: 700.0);
    // For Show Image Direct in Page Current witout Reload Page
    if (type == "image") {
      if (myfile != null) {
        setState(() {
          file = File(myfile.path);
        });
      }
    }
    if (type == "licence") {
      if (myfile != null) {
        setState(() {
          file2 = File(myfile.path);
        });
      }
    }
  }

  // End Uploaded Images

  addTaxi() async {
    // assert(_catname != null) ;
    var formstate = formdata.currentState;
    if (formstate.validate()) {

     
      formstate.save();
      if (file == null) {
        return showdialogall(context, "خطأ", "يجب اضافة صورة السيارة");
      }
      if (file2 == null) {
        return showdialogall(context, "خطأ", "يجب اضافة صورة رخصة القيادة ");
      }
      if (taxiBrand == null) {
        return showdialogall(context, "خطأ", "يجب تحديد القسم");
      }


      showLoading(context) ; 
      
      var responsebody = await crud.addTaxitwo(widget.email, taxiModel, taxiYear, taxiBrand,
          taxiDescription, taxiPrice, file, file2);
          print(responsebody) ; 
       if (responsebody['status'] == "success"){
          Navigator.of(context).pushReplacementNamed("taxi");
       }
    } else {
      print("Not Valid");
    }
  }

  // Start DropDown Menu

  void getCatName() async {
    var listData = await crud.readData("cattaxi") ;
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

    getCatName();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Text('اضافة سيارة'),
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
                            taxiModel = val;
                          },
                          validator: (val) {
                            return validInput(
                                val, 3, 40, "يكون موديل السيارة ");
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.fastfood),
                            labelText: "اكتب هنا موديل السيارة",
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
         
                        
                        TextFormField(
                          onSaved: (val) {
                            taxiYear = val;
                          },
                          validator: (val) {
                            return validInput(val, 0, 20, "تكون سنة الصنع   ");
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.attach_money),
                            labelText: "اكتب هنا سنة الصنع  ",
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        DropdownSearch(
                          items: _datadropdown,
                          label: "اختر هنا اسم القسم",
                          onChanged: (val) {
                            taxiBrand = val;
                          },
                          selectedItem: "اسم القسم",
                        ),
                      ],
                    ),
                  ),
                ),
                 
                 Row(
                   mainAxisAlignment:MainAxisAlignment.center ,
                   children: [

                      
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: RaisedButton(
                    child: Text("صورة الرخصة",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    color: file2 == null ?  Colors.red : Colors.green,
                    onPressed: () {
                      showbottommenu("licence");
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: RaisedButton(
                    child: Text("صورة السيارة",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    color:  file == null ?  Colors.red : Colors.green  ,
                    onPressed: () {
                      showbottommenu("image");
                    },
                  ),
                ),

                 ],) , 
                // Container(
                //     width: 200,
                //     height: 200,
                //     child: file == null
                //         ? Center(child: Text(" لم يتم اختيار صورة "))
                //         : Image.file(file)),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: RaisedButton(
                    child: Text("اضافة تكسي",
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                    color: Colors.blue,
                    onPressed: addTaxi,
                  ),
                )
              ],
            )));
  }

  showbottommenu(String type) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(10),
            height: 190,
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
                    if (type == "image") {
                      _choosecamera("image");
                    }
                    if (type == "licence") {
                      _choosecamera("licence");
                    }
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
                    if (type == "image") {
                      _choosegallery("image");
                    }
                    if (type == "licence") {
                      _choosegallery("licence");
                    }
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
