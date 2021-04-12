import 'package:admin/components/crud.dart';
import 'package:admin/pages/items/edititems.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemsList extends StatelessWidget {
  Crud crud = new Crud();
  final id;
  final name;
  final price;
  final itemcat;
  final image;
  final itemcatid;
  ItemsList(
      {this.id,
      this.name,
      this.price,
      this.itemcat,
      this.image,
      this.itemcatid});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return EditItem(
              itemid: id,
              itemcat: itemcat,
              itemname: name,
              itemprice: price,
              item_catid: itemcatid,
              image: image);
        }));
      },
      child: Container(
          child: Card(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: CachedNetworkImage(
                imageUrl: "http://${crud.server_name}/upload/items/$image",
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
                title: Text("${name}"),
                trailing: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    "${price}  KD  ",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                subtitle: Text("${itemcat}"),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
