import 'dart:io';
import 'package:admin/components/alert.dart';
import 'package:admin/components/chooseimage.dart';
import 'package:admin/components/crud.dart';
import 'package:admin/const.dart';
import 'package:flutter/material.dart';

class EditImages extends StatefulWidget {
  EditImages({Key key}) : super(key: key);

  @override
  _EditImagesState createState() => _EditImagesState();
}

class _EditImagesState extends State<EditImages> {
  File file,
      filetaxi,
      filefood,
      filepay,
      filesq,
      filerq,
      filesp,
      filecharge,
      filesa;

  Crud crud = new Crud();

  var urlEditImages = "https://${serverName}/imagehome/editimagehome.php";

  // For ImagePicker Choose Image

  Future _chooseGallerytaxi() async {
    filetaxi = await myChooseGallery();
    setState(() {});
  }

  Future _chooseCamerataxi() async {
    filetaxi = await myChooseCamera();
    setState(() {});
  }

  Future _chooseGalleryfood() async {
    filefood = await myChooseGallery();
    setState(() {});
  }

  Future _chooseCamerafood() async {
    filefood = await myChooseCamera();
    setState(() {});
  }

  Future _chooseGallerypay() async {
    filepay = await myChooseGallery();
    setState(() {});
  }

  Future _chooseCamerapay() async {
    filepay = await myChooseCamera();
    setState(() {});
  }

  Future _chooseGallerysa() async {
    filesa = await myChooseGallery();
    setState(() {});
  }

  Future _chooseCamerasa() async {
    filesa = await myChooseCamera();
    setState(() {});
  }

  Future _chooseGallerysp() async {
    filesp = await myChooseGallery();
    setState(() {});
  }

  Future _chooseCamerasp() async {
    filesp = await myChooseCamera();
    setState(() {});
  }

  Future _chooseGallerysq() async {
    filesq = await myChooseGallery();
    setState(() {});
  }

  Future _chooseCamerasq() async {
    filesq = await myChooseCamera();
    setState(() {});
  }

  Future _chooseGalleryrq() async {
    filerq = await myChooseGallery();
    setState(() {});
  }

  Future _chooseCamerarq() async {
    filerq = await myChooseCamera();
    setState(() {});
  }

  Future _chooseGallerycharge() async {
    filecharge = await myChooseGallery();
    setState(() {});
  }

  Future _chooseCameracharge() async {
    filecharge = await myChooseCamera();
    setState(() {});
  }

  //   if (type == "taxi") filetaxi = await myChooseCamera();
  // if (type == "food") filefood = await myChooseCamera();
  // if (type == "pay") filepay = await myChooseCamera();
  // if (type == "sq") filesq = await myChooseCamera();
  // if (type == "rq") filerq = await myChooseCamera();
  // if (type == "sp") filesp = await myChooseCamera();
  // if (type == "charge") filecharge = await myChooseCamera();
  // if (type == "sa") filesa = await myChooseCamera();
  // Add Categories To DataBase

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('?????????? ???????? ????????????'),
        ),
        body: Container(
          child: Column(children: [
            butttonEditImage("?????????? ???????? ????????????", "taxi", filetaxi),
            butttonEditImage("?????????? ???????? ????????????", "food", filefood),
            butttonEditImage("?????????? ???????? ?????????????? ????????????", "pay", filepay),
            butttonEditImage("?????????? ???????? ?????????????? ????????????", "sa", filesa),
            butttonEditImage("??????????  ???????? ??????  ????????????", "charge", filecharge),
            butttonEditImage("?????????? ???????? ?????????? ?????????? ????????????", "sp", filesp),
            butttonEditImage("?????????? ???????? ?????????????? ???? qrcode ", "rq", filerq),
            butttonEditImage("?????????? ?????????? ???? ???????? qrcode", "sq", filesq),
          ]),
        ),
      ),
    );
  }

  butttonEditImage(String text, String type, File file) {
    return InkWell(
      onTap: () {
        if (type == "taxi")
          showbottommenu(context, _chooseCamerataxi, _chooseGallerytaxi);
        if (type == "food")
          showbottommenu(context, _chooseCamerafood, _chooseGalleryfood);
        if (type == "pay")
          showbottommenu(context, _chooseCamerapay, _chooseGallerypay);
        if (type == "sq")
          showbottommenu(context, _chooseCamerasq, _chooseGallerysq);
        if (type == "rq")
          showbottommenu(context, _chooseCamerarq, _chooseGalleryrq);
        if (type == "sp")
          showbottommenu(context, _chooseCamerasp, _chooseGallerysp);
        if (type == "charge")
          showbottommenu(context, _chooseCameracharge, _chooseGallerycharge);
        if (type == "sa")
          showbottommenu(context, _chooseCamerasa, _chooseGallerysa);
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          child: Row(
            children: [
              Text("$text", style: TextStyle(fontSize: 16)),
              Spacer(),
              if (file != null)
                InkWell(
                  onTap: () async {
                    if (file != null) {
                      showLoading(context);
                      var response = await crud.addRequestWithImageOne(
                          urlEditImages, type, file);
                      Navigator.of(context).pushNamed("home");
                      print("$response");
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.green,
                      child: Text(
                        "?????? ??????????????",
                        style: TextStyle(color: Colors.white),
                      )),
                )
            ],
          ),
        ),
      ),
    );
  }
}
