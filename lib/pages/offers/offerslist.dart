import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OffersList extends StatelessWidget {
  final servername;
  final list;
  OffersList({this.list, this.servername});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          child: Card(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: CachedNetworkImage(
                imageUrl:
                    "http://$servername/upload/offers/${list['offers_image']}", 
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 4,
              child: ListTile(
                title: Text("${list['offers_title']}"),
                subtitle: Text("${list['offers_body']}"),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
