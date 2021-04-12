import 'package:admin/components/alert.dart';
import 'package:admin/components/crud.dart';
import 'package:admin/components/valid.dart';
import 'package:flutter/material.dart';

class SendMoney extends StatefulWidget {
  SendMoney({Key key}) : super(key: key);
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  Crud crud = new Crud();
  var units;
  var phone;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  transferMoney() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      formdata.save();
      Map data = {"phone": phone, "units": units};
      showLoading(context) ; 
      var responsbody = await crud.writeData("transfermoney", data);
      if (responsbody['status'] == "success") {
        Navigator.of(context).pushNamed("home");
      } else {
        Navigator.of(context).pop() ; 
        showdialogall(context, "تنبيه", "هذا المستخدم غير موجود") ; 
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text('تحويل رصيد'),
          ),
          body: Form(
            autovalidate: true ,
            key: formstate,
            child: Column(
              children: [
                buildTextForm("ادخل الرصيد الذي تريد تحويله",
                    Icon(Icons.monetization_on), "units"),
                buildTextForm("ادخل رقم الذي تريد التحويل له",
                    Icon(Icons.phone), "phone"),
                    SizedBox(height: 20,) , 
                RaisedButton(
                  onPressed: () {
                     transferMoney()   ;
                  },
                  color: Colors.blue,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 3),
                    child: Text(
                      " تحويل ",
                      style: TextStyle(color: Colors.white , fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  TextFormField buildTextForm(String label, Icon icons, [type]) {
    return TextFormField(
        onSaved: (val) {
          if (type == "units") {
            units = val;
          }
          if (type == "phone") {
            phone = val;
          }
        },
        validator: (val) {
          if (type == "units") {
           return  validInput(val, 0, 6, "يكون تحويل الرصيد " , "number");
          }
          if (type == "phone") {
           return  validInput(val, 0, 20, "يكون رقم الهاتف", "phone");
          }
        },
        decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            prefixIcon: icons));
  }
}
