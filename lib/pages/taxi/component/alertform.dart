
import 'package:admin/components/crud.dart';
import 'package:admin/components/valid.dart';
import 'package:flutter/material.dart';


showdialogallApproveTaxi(context , taxiid) {
  return showDialog(
      context: context,
      builder: (context) {
        return AprroveFormTaxiWithAlert(texiid: taxiid);
      });
}

class AprroveFormTaxiWithAlert extends StatefulWidget {
  final texiid ; 
  AprroveFormTaxiWithAlert({Key key , this.texiid}) : super(key: key);
  @override
  _AprroveFormTaxiWithAlertState createState() => _AprroveFormTaxiWithAlertState();
}

class _AprroveFormTaxiWithAlertState extends State<AprroveFormTaxiWithAlert> {

Crud crud = new Crud() ; 
var initialPrice;
var priceKm;

GlobalKey<FormState> formstateapprovetaxi = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              titlePadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.blue,
                  child: Text(
                    "تنبيه",
                    style: TextStyle(color: Colors.white),
                  )),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Flexible(
                // height: 150,
                // width: MediaQuery.of(context).size.width - 100,
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Form(
                    key: formstateapprovetaxi,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("الرجاء ادخل المعلومات التالية"),
                          SizedBox(height: 10),
                          TextFormField(
                              // controller: initialprice,
                              onSaved: (val) {
                                initialPrice = val;
                              },
                              validator: (val) {
                                return validInput(val, 0, 3,
                                    "يكون السعر الابتدائي", "number");
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(4),
                                  hintText:
                                      "ادخل هنا سعر التوصيل للكيلو متر الواحد",
                                  hintStyle: TextStyle(fontSize: 12),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey[500],
                                          style: BorderStyle.solid,
                                          width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue,
                                          style: BorderStyle.solid,
                                          width: 1)))),
                          SizedBox(height: 10),
                          TextFormField(
                            onSaved: (val) {
                              priceKm = val;
                            },
                            validator: (val) {
                              return validInput(
                                  val, 0, 3, "يكون السعر للكيلو متر", "number");
                            },
                            // controller: pricekm,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(4),
                                hintText:
                                    "ادخل هنا سعر التوصيل للكيلو متر الواحد",
                                hintStyle: TextStyle(fontSize: 12),
                                filled: true,
                                fillColor: Colors.grey[200],
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[500],
                                        style: BorderStyle.solid,
                                        width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue,
                                        style: BorderStyle.solid,
                                        width: 1))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              ],),
              actions: <Widget>[
                FlatButton(
                  child: Text("موافق"),
                  onPressed: () async {
                    var formdata = formstateapprovetaxi.currentState;
                    if (formdata.validate()) {
                      formdata.save() ; 
                      Map data = {
                        "price": priceKm.toString(),
                        "initialprice": initialPrice.toString() , 
                        "id" : widget.texiid.toString()
                      };
                      print(data) ; 

                      await  crud.writeData("approvetaxi", data) ; 
                      Navigator.of(context).pushReplacementNamed("taxi"); 
                    } else {}
                  },
                ),
              ],
            )) ; 
  }
}