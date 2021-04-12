import 'package:admin/components/crud.dart';
import 'package:admin/pages/categories/editcategories.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryList extends StatelessWidget {
  final id, name , nameen, image;
  CategoryList({this.name , this.nameen, this.image, this.id});
  Crud crud = new Crud();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return EditCategories(
              catid: id,
              catname: name,
              catimage: image,
              catnameen  :nameen
            );
          }));
        },
        child: Container(
            child: Card(
          child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(right: BorderSide(color: Colors.red, width: 5))),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl:
                        "http://${crud.server_name}/upload/categories/$image",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              )),
        )));
  }
}
