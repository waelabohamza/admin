import 'package:admin/components/crud.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class OrdersTaxi extends StatefulWidget {
  OrdersTaxi({Key key}) : super(key: key);
  @override
  _OrdersTaxiState createState() => _OrdersTaxiState();
}

class _OrdersTaxiState extends State<OrdersTaxi> {
  Crud crud = new Crud();
  setLocal() async {
    await Jiffy.locale("ar");
  }

  @override
  void initState() {
    super.initState();
    setLocal();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: FutureBuilder(
        future: crud.readData("orderstaxi"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData){
            if (snapshot.data[0] == "faild") {
              return Text("not found");
            }else{
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return ListOrdersTaxi(orders: snapshot.data[i]);
                  });
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
class ListOrdersTaxi extends StatelessWidget {
  final orders;
  const ListOrdersTaxi({Key key, this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Container(
              margin: EdgeInsets.only(top: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "معرف الطلبية : ${orders['orderstaxi_id']}",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 16),
                          children: <TextSpan>[
                        TextSpan(
                            text: "اسم السائق : ",
                            style: TextStyle(color: Colors.grey)),
                        TextSpan(
                            text: "${orders['taxi_username']}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600))
                      ])),
                        RichText(
                      text: TextSpan(
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 16),
                          children: <TextSpan>[
                        TextSpan(
                            text: "هاتف السائق : ",
                            style: TextStyle(color: Colors.grey)),
                        TextSpan(
                            text: "${orders['taxi_phone']}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600))
                      ])),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 16),
                          children: <TextSpan>[
                        TextSpan(
                            text: "اسم الزبون : ",
                            style: TextStyle(color: Colors.grey)),
                        TextSpan(
                            text: "${orders['username']}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600))
                      ])),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 16),
                          children: <TextSpan>[
                        TextSpan(
                            text: "هاتف الزبون  : ",
                            style: TextStyle(color: Colors.grey)),
                        TextSpan(
                            text: "${orders['user_phone']}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600))
                      ])),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 16),
                          children: <TextSpan>[
                        TextSpan(
                            text: " السعر الكلي : ",
                            style: TextStyle(color: Colors.grey)),
                        TextSpan(
                            text: " ${orders['orderstaxi_price']} د.ك",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w600))
                      ])),
                ],
              ),
            ),
            trailing: Container(
                margin: EdgeInsets.only(top: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "${Jiffy(orders['orders_date']).fromNow()}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )),
          ),
          Container(
            padding: EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
            child: Row(
              children: [
             
                Expanded(
                  child: Container(),
                ),
         
              ],
            ),
          )
        ],
      ),
    ));
  }
}
