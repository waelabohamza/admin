import 'package:admin/components/valid.dart';
import 'package:admin/pages/restaurants/addrestaurantstwo.dart';
import 'package:flutter/material.dart';
import 'package:admin/components/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:admin/components/alert.dart' as alert;

class AddRestaurants extends StatefulWidget {
  AddRestaurants({Key key}) : super(key: key);

  @override
  _AddRestaurantsState createState() => _AddRestaurantsState();
}

class _AddRestaurantsState extends State<AddRestaurants> {
  Crud crud = new Crud();

  bool loading = false;

  File filelogo;
  // File myfilelogo;
  File filelisence;
  // File myfilelicence;

  // Start Uploaded Images

  void _choosegallery(String type) async {
    final myfile = await ImagePicker().getImage(source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500.0,
        maxWidth: 500.0);
    // For Show Image Direct in Page Current witout Reload Page
    if (type == "logo") {
      if (myfile != null) {
        setState(() {
          filelogo = File(myfile.path);
        });
      }
    }
    if (type == "lisence") {
      if (myfile != null) {
        setState(() {
          filelisence = File(myfile.path);
        });
      }
    }
  }

  void _choosecamera(String type) async {
    final myfile = await ImagePicker().getImage(source: ImageSource.camera, imageQuality: 70 , maxHeight: 700.0 , maxWidth: 700.0);
    // For Show Image Direct in Page Current witout Reload Page
    if (type == "logo") {
      if (myfile != null) {
        setState(() {
          filelogo = File(myfile.path);
        });
      }
    }
    if (type == "lisence") {
      if (myfile != null) {
        setState(() {
          filelisence = File(myfile.path);
        });
      }
    }
  }

  // End Uploaded Images

  var _name,
      _password,
      _email,
      _phone , 
      timedelivery,
      pricedelivery,
      description,
      restype ;

  GlobalKey<FormState> _formstate = new GlobalKey<FormState>();

  addRestaurants() async {
    if (filelogo == null)
      return alert.showdialogall(context, "خطأ", "يجب اختيار شعار للمطعم ");
    if (filelisence == null)
      return alert.showdialogall(context, "خطأ", "يجب رفع صورة الرخصة");
    // Var For Images

    var formdata = _formstate.currentState;
    if (formdata.validate()) {
      formdata.save();
      setState(() {
        loading = true;
      });
      if (loading == true) {
        alert.showLoading(context);
      }
    var responsebody  =  await crud.addRestarants(_name, _password, _email , _phone,  filelogo, filelisence);
      setState(() {
        loading = false;
      });
      if (responsebody['status'] == "success"){
          Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return AddRestaurantsTwo(
          res_email: _email,
        );
      }));

      }else {
        Navigator.of(context).pop() ; 
        alert.showdialogall(context, "اشعار", "البريد الالكتروني موجود");
      }
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text('اضافة مطعم'),
          ),
          body: ListView(
            children: <Widget>[
              Form(
                  key: _formstate,
                  child: Column(
                    children: <Widget>[
                      buildTextForm(
                          "ادخل اسم المطعم", Icon(Icons.restaurant), "name"),
                      buildTextForm(
                          "ادخل رقم الهاتف", Icon(Icons.phone), "phone"),
                      buildTextForm("ادخل البريد الالكتروني ",
                          Icon(Icons.email), "email"),
                      buildTextForm(
                          "ادخل كلمة المرور ", Icon(Icons.vpn_key), "password")  , 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                              color: (filelogo == null)
                                  ? Colors.red
                                  : Colors.green,
                              child: Text("صورة الشعار",
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                return showbottommenu("logo");
                              }),
                          SizedBox(
                            width: 20,
                          ),
                          RaisedButton(
                              color: (filelisence == null)
                                  ? Colors.red
                                  : Colors.green,
                              child: Text(
                                "صورة الرخصة",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                return showbottommenu("lisence");
                              })
                        ],
                      ),
                      RaisedButton(
                        child: Text(
                          "اضافة المطعم",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: addRestaurants,
                      )
                    ],
                  ))
            ],
          )),
    );
  }

  TextFormField buildTextForm(String label, Icon icons, typetext) {
    return TextFormField(
      validator: (val) {
        if (typetext == "email") {
          return validInput(val, 4, 30, "يكون البريد الالكتروني" , 'email');
        }
        if (typetext == "phone") {
          return validInput(val, 4, 20, "يكون رقم الهاتف " , 'phone');
        }
        if (typetext == "name") {
          return validInput(val, 4, 30, "يكون اسم المطعم");
        }
        if (typetext == "password") {
          return validInput(val, 4, 20, "تكون كلمة المرور");
        }
        if (typetext == "timedelivery") {
          return validInput(val, 1, 20, " يكون زمن التوصيل ", "number");
        }
        if (typetext == "pricedelivery") {
          return validInput(val, 0, 20, " يكون سعر التوصيل ", "number");
        }
        if (typetext == "description") {
          return validInput(val, 10, 100, " يكون الوصف  ");
        }
        if (typetext == "restype") {
          return validInput(val, 5, 30, " يكون نوع المطعم ");
        }
      },
      onSaved: (val) {
        if (typetext == "email") {
          _email = val;
        }  if (typetext == "phone") {
          _phone = val;
        }
        if (typetext == "name") {
          _name = val;
        }
        if (typetext == "password") {
          _password = val;
        }
        if (typetext == "timedelivery") {
          timedelivery = val;
        }
        if (typetext == "pricedelivery") {
          pricedelivery = val;
        }
        if (typetext == "description") {
          description = val;
        }
        if (typetext == "restype") {
          restype = val;
        }
      },
      minLines: 1,
      maxLines: typetext == "description" ? 3 : 1,
      keyboardType: typetext == "pricedelivery" || typetext == "timedelivery" || typetext == "phone"
          ? TextInputType.number
          : TextInputType.text,
      decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: icons),
    );
  }

  showbottommenu(String type) {
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
                    if (type == "logo") {
                      _choosecamera("logo");
                    }
                    if (type == "lisence") {
                      _choosecamera("lisence");
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
                    if (type == "logo") {
                      _choosegallery("logo");
                    }
                    if (type == "lisence") {
                      _choosegallery("lisence");
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
