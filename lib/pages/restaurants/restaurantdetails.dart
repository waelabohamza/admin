import 'package:flutter/material.dart';
import 'package:admin/components/crud.dart';
// import 'package:carousel_pro/carousel_pro.dart';

class RestaurantDetails extends StatelessWidget {
  final restaurantdetails;
  RestaurantDetails({this.restaurantdetails});
  Crud crud = new Crud();

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
              Image.asset(
                'http://${crud.server_name}/upload/reslogo/${restaurantdetails['res_image']}',
                height: 250.0,
                width: double.infinity,
              ),
              // NetworkImage('http://${crud.server_name}/upload/reslisence/${restaurantdetails['res_lisence']}'),

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
                        "blue", "اسم المطعم : ", restaurantdetails['res_name']),
                    buildTextInfo("white", "البريد الالكتروني : ",
                        restaurantdetails['res_email']),
                    buildTextInfo("blue", " رقم الهاتف  ",
                        restaurantdetails['res_phone']),
                    buildTextInfo("white", "نوع المطعم : ",
                        restaurantdetails['res_type']),
                    buildTextInfo("blue", "وقت التوصيل : ",
                        "${restaurantdetails['res_time_delivery']} دقيقة"),
                    buildTextInfo("white", "سعر التوصيل : ",
                        "${restaurantdetails['res_price_delivery']} د.ك"),
                    buildTextInfo("blue", "العنوان : ",
                        "${restaurantdetails['res_area']} / ${restaurantdetails['res_street']}"),
                    buildTextInfo("white", "الحساب الحالي :  ",
                        "${restaurantdetails['res_balance']} د.ك "),
                    buildTextInfo(
                        "blue",
                        "الحالة : ",
                        int.parse(restaurantdetails['res_approve']) == 0
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
