import 'package:admin/pages/restaurants/addrestaurantsfour.dart';
import 'package:flutter/material.dart';
import 'package:admin/components/crud.dart';
import 'package:admin/components/valid.dart';

class AddRestaurantsThree extends StatefulWidget {
  final resemail;
  AddRestaurantsThree(
      {Key key, this.resemail })
      : super(key: key);

  @override
  _AddRestaurantsThreeState createState() => _AddRestaurantsThreeState();
}

class _AddRestaurantsThreeState extends State<AddRestaurantsThree> {
  Crud crud = new Crud();

  var country, area, street;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  signUpThree() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      formdata.save();
      Map data = {
        "resemail": widget.resemail.toString(),
        "country": country,
        "area": area,
        "street": street,
      };
      var responsebody = await crud.writeData("addresturantsthree", data);
      if (responsebody['status'] == "success") {
        // Navigator.of(context).pushReplacementNamed("restaurants");
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return AddRestaurantsFour(resemail: widget.resemail); 
        }));
      }
    } else {
      print("not vaild");
      print(street);
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
                    buildTextForm(
                          "البلد", Icon(Icons.flag), "country"),
                    buildTextForm(  "المنطقة",
                        Icon(Icons.location_city), "area"),
                    buildTextForm(   "الشارع",
                        Icon(Icons.streetview), "street"),
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

  TextFormField buildTextForm(  String labeltext, Icon icon, type) {
    return TextFormField(
      onSaved: (val) {
        if (type == "country") {
          country = val;
        }
        if (type == "area") {
          area = val;
        }
        if (type == "street") {
          street = val;
        }
      },
      
      validator: (val) {
        if (type == "country") {
          return validInput(val, 4, 20, "يكون اسم البلد");
        }
        if (type == "area") {
          return validInput(val, 4, 20, "يكون  اسم المنطقة");
        }
        if (type == "street") {
          return validInput(val, 4, 20, "يكون اسم الشارع");
        }
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
