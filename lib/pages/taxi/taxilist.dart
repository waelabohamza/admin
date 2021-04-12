import 'package:admin/pages/message/specficmessage.dart';
import 'package:admin/pages/taxi/taxidetails.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TaxiList extends StatelessWidget {
  final crud ; 
  final taxilist;
  TaxiList({this.taxilist , this.crud});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return TaxiDetails(taxidetails: taxilist , crud: crud,);
            }));
          },
          child: Container(
            child: Card(
                child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child:CachedNetworkImage(
                    imageUrl:
                        "http://${crud.server_name}/upload/taxiimage/${taxilist['taxi_image']}",
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
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text("اسم السائق :  ${taxilist['taxi_username']}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(" الموديل :  ${taxilist['taxi_model']}"),
                                   Text(" القسم :  ${taxilist['cat_name']}"),
                                Text(
                                  "${taxilist['taxi_email']}",
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
                                        type: "taxi",
                                        id: taxilist['taxi_id']);
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
        (int.parse(taxilist['taxi_approve']) == "0")
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
