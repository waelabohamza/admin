import 'package:flutter/material.dart';
import 'package:admin/components/crud.dart';
import 'package:admin/components/valid.dart';

class AddRestaurantsFour extends StatefulWidget {
  final resemail;
  AddRestaurantsFour({Key key, this.resemail}) : super(key: key);

  @override
  _AddRestaurantsFourState createState() => _AddRestaurantsFourState();
}

class _AddRestaurantsFourState extends State<AddRestaurantsFour> {
  Crud crud = new Crud();

  var price, restype, description, time;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  signUpThree() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      formdata.save();
      Map data = {
        "resemail": widget.resemail.toString(),
        "pricedelivery": price.toString(),
        "type": restype.toString() , 
        "description": description.toString(),
        "timedelivery": time.toString()
      };
      var responsebody = await crud.writeData("addresturantsfour", data);
      if (responsebody['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("restaurants");
      }
    } else {
      print("not vaild");
      // print(street);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('اعدادات المطعم'),
          ),
          body: Container(
            child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    buildTextForm("سعر التوصيل", Icon(Icons.money), "price"),
                    buildTextForm(
                        "وقت التوصيل", Icon(Icons.time_to_leave), "time"),
                    buildTextForm("النوع", Icon(Icons.category), "type"),
                    buildTextForm(
                        "الوصف", Icon(Icons.description), "description"),
                    Container(
                      child: MaterialButton(
                        onPressed: () {
                          return signUpThree();
                        },
                        child: Text(
                          "تم",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        color: Colors.red,
                      ),
                    )
                  ],
                )),
          ),
        ));
  }

  TextFormField buildTextForm(String labeltext, Icon icon, type){
    return TextFormField(
      onSaved: (val) {
        if (type == "price") {
          price = val;
        }
        if (type == "time") {
          time = val;
        }
        if (type == "type") {
          restype = val;
        }
        if (type == "description") {
          description = val;
        }
      },
      validator: (val) {
        if (type == "price") {
          return validInput(val, 0, 5, "يكون سعر التوصيل");
        }
        if (type == "time") {
          return validInput(val, 0, 3, "يكون  وقت التوصيل");
        }
        if (type == "type") {
          return validInput(val, 4, 20, "يكون نوع التوصيل");
        }
        if (type == "description") {
          return validInput(val, 4, 254, "يكون الوصف ");
        }
        return null ; 
      },
      decoration: InputDecoration(
          labelText: labeltext,
          //  labelStyle: TextStyle(color: Colors.red),
          prefixIcon: icon,
          filled: true,
          fillColor: Colors.white),
    );
  }
}
