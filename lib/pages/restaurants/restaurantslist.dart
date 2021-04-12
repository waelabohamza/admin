import 'package:admin/pages/message/specficmessage.dart';
import 'package:flutter/material.dart';
import 'package:admin/pages/restaurants/restaurantdetails.dart';
import 'package:admin/components/crud.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RestaurantsList extends StatelessWidget {
  Crud crud = new Crud();
  final restaurantslist;
  RestaurantsList({this.restaurantslist});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return RestaurantDetails(restaurantdetails: restaurantslist);
            }));
          },
          child: Container(
            child: Card(
                child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: CachedNetworkImage(
                    imageUrl:
                        "http://${crud.server_name}/upload/reslogo/${restaurantslist['res_image']}",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                              title:
                                  Text("مطعم ${restaurantslist['res_name']}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("${restaurantslist['res_type']}"),
                                  Text(
                                    "${restaurantslist['res_email']}",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.message),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return SpecficMessage(
                                        type: "res",
                                        id: restaurantslist['res_id']);
                                  }));
                                },
                              )
                              )
                        ],
                      ),
                    ))
              ],
            )),
          ),
        ),
        (int.parse(restaurantslist['res_approve']) == "0")
            ? Positioned(
                left: 0,
                top: 10,
                child: Container(
                  child: Text(
                    "موافقة",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  color: Colors.red,
                  width: 50,
                  height: 20,
                ))
            : SizedBox()
      ],
    );
  }
}
