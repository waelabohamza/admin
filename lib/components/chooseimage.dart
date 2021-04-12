import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

myChooseGallery() async {
  final myfile = await ImagePicker().getImage(source: ImageSource.gallery);
  // For Show Image Direct in Page Current witout Reload Page
  if (myfile != null) {
    return File(myfile.path);
  }
  return null;
  // setState(() {
  // });
}

myChooseCamera() async {
  final myfile = await ImagePicker().getImage(source: ImageSource.camera);
  // For Show Image Direct in Page Current witout Reload Page
  if (myfile != null) {
    return File(myfile.path);
  }
  return null;
}

showbottommenu(context, choosecamera(), choosegallery()) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "اختيار صورة",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  ListTile(
                    onTap: () {
                      choosecamera();
                      Navigator.of(context).pop();
                    },
                    leading: Icon(
                      Icons.camera_alt,
                      size: 40,
                    ),
                    title: Text("صورة من الكاميرا",
                        style: TextStyle(fontSize: 20)),
                  ),
                  ListTile(
                    onTap: () {
                      choosegallery();
                      Navigator.of(context).pop();
                    },
                    leading: Icon(
                      Icons.image,
                      size: 40,
                    ),
                    title: Text(" صورة من الاستديو",
                        style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ));
      });
}
