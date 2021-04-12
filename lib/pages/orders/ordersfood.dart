import 'package:admin/components/crud.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class OrdersFood extends StatefulWidget {
  OrdersFood({Key key}) : super(key: key);
  @override
  _OrdersFoodState createState() => _OrdersFoodState();
}

class _OrdersFoodState extends State<OrdersFood> {
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
        future: crud.readData("ordersfood"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData){
            if (snapshot.data[0] == "faild") {
              return Text("not found");
            }else{
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return ListOrdersFood(orders: snapshot.data[i]);
                  });
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
class ListOrdersFood extends StatelessWidget {
  final orders;
  const ListOrdersFood({Key key, this.orders}) : super(key: key);

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
                    "معرف الطلبية : ${orders['orders_id']}",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 16),
                          children: <TextSpan>[
                        TextSpan(
                            text: "اسم المطعم : ",
                            style: TextStyle(color: Colors.grey)),
                        TextSpan(
                            text: "${orders['res_name']}",
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
                            text: " ${orders['orders_total']} د.ك",
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
                // int.parse(orders['orders_status']) == 0
                //     ? Text(
                //         "بانتظار الموافقة",
                //         style: TextStyle(
                //             color: Colors.green,
                //             fontSize: 18,
                //             fontWeight: FontWeight.w600),
                //       )
                //     : int.parse(orders['orders_status']) == 1
                //         ? Text(
                //             "قيد التوصيل ",
                //             style: TextStyle(
                //                 color: Colors.green,
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w600),
                //           )
                //         : Text(
                //             "تم التوصيل ",
                //             style: TextStyle(
                //                 color: Colors.green,
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w600),
                //           ),
                Expanded(
                  child: Container(),
                ),
                // InkWell(
                //   child: Container(
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //       decoration: BoxDecoration(
                //           border: Border.all(color: Colors.black, width: 1.3),
                //           borderRadius: BorderRadius.circular(50)),
                //       child: Text(
                //         "التفاصيل",
                //         style: TextStyle(
                //             fontWeight: FontWeight.w600, color: Colors.grey),
                //       )),
                //   onTap: () {},
                // )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
