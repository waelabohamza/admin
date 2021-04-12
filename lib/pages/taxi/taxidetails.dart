import 'package:flutter/material.dart';
// import 'package:carousel_pro/carousel_pro.dart';

class TaxiDetails extends StatelessWidget {
  final taxidetails;
  final crud;
  TaxiDetails({this.taxidetails, this.crud});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('التفاصيل'),
          ),
          body: ListView(
            children: <Widget>[
              Image.network(
                'http://${crud.server_name}/upload/taxiimage/${taxidetails['taxi_image']}',
                height: 250.0,
                width: double.infinity,
              ),
              // NetworkImage('http://${crud.server_name}/upload/taxilicence/${taxidetails['taxi_licence']}'),

              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "معلومات",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildTextInfo(
                        "blue", "اسم السائق : ", taxidetails['taxi_username']),
                    buildTextInfo("white", "البريد الالكتروني : ",
                        taxidetails['taxi_email']),
                    buildTextInfo(
                        "blue", " رقم الهاتف  ", taxidetails['taxi_phone']),
                    buildTextInfo(
                        "white", "الموديل : ", taxidetails['taxi_model']),
                    buildTextInfo(
                        "blue", " القسم : ", "${taxidetails['cat_name']}  "),
                    buildTextInfo("white", "سعر التوصيل : ",
                        "${taxidetails['taxi_price']} د.ك للكيلو متر"),
                    // buildTextInfo("blue", "العنوان : ",
                    //     "${taxidetails['res_area']} / ${taxidetails['res_street']}"),
                    // buildTextInfo("white", "الحساب الحالي :  ",
                    //     "${taxidetails['res_balance']} د.ك "),
                    buildTextInfo(
                        "blue",
                        "الحالة : ",
                        int.parse(taxidetails['taxi_approve']) == 0
                            ? "بانتظار الموافقة  "
                            : " تمت الموافقة "),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Container buildTextInfo(String color, String content, String description) {
    return Container(
      width: double.infinity,
      color: color == "white" ? Colors.white : Colors.blue,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: RichText(
          text: TextSpan(style: TextStyle(fontSize: 16), children: <TextSpan>[
        TextSpan(
            text: content,
            style: color != "white"
                ? TextStyle(color: Colors.white)
                : TextStyle(color: Colors.blue)),
        TextSpan(
            text: description,
            style: color != "white"
                ? TextStyle(color: Colors.white)
                : TextStyle(color: Colors.blue)),
      ])),
    );
  }
}
