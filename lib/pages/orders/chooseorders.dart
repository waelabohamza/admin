import 'package:admin/pages/orders/ordersfood.dart';
import 'package:admin/pages/orders/orderstaxi.dart';
import 'package:flutter/material.dart';

class ChooseOrders extends StatefulWidget {
  ChooseOrders({Key key}) : super(key: key);

  @override
  _ChooseOrdersState createState() => _ChooseOrdersState();
}

class _ChooseOrdersState extends State<ChooseOrders> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  title: Text('الطلبات'),
                  bottom: TabBar(tabs: [
                    Text("المطاعم"),
                    Text("التكاسي"),
                  ]),
                ),
                body: TabBarView(children: [
                  OrdersFood()  , 
                 OrdersTaxi()
                ]))));
  }
}
