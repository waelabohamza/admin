import 'package:admin/components/alert.dart';
import 'package:admin/components/buildforminput.dart';
import 'package:admin/components/crud.dart';
import 'package:flutter/material.dart';

class ChooseCatMessage extends StatefulWidget {
  ChooseCatMessage({Key key}) : super(key: key);

  @override
  _ChooseCatMessageState createState() => _ChooseCatMessageState();
}

class _ChooseCatMessageState extends State<ChooseCatMessage> {

  Crud crud  = new Crud() ; 

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  TextEditingController title = new TextEditingController();
  TextEditingController body = new TextEditingController();
  var cat ; 

  _chooseCat(val) {
    setState(() {
       cat = val    ; 
    });
    print(cat) ; 
  }

  sendMessage() async{
      String mytitle  = "خطأ" ; 
      String mycontent = "يجب تحديد القسم الذي تريد ارسال الرسالة اليه" ; 
      if (cat == null) return showdialogall(context, mytitle, mycontent) ; 
       var formdata = formstate.currentState ;
       if (formdata.validate()) {
          showLoading(context) ; 
          Map data = {"title"  : title.text   ,  "body" : body.text ,  "cat" :  cat.toString() }; 
          await crud.writeData("sendmessage", data) ; 
          Navigator.of(context).pushReplacementNamed("home") ; 
       }else {
         print(title.text)  ; 
         print("notvalid")  ; 
       }

  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Text('الرسائل'),
            ),
            body: ListView(children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Form(
                      key: formstate,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(children: <Widget>[
                        buildFormInput(2, 20, "يكون العنوان", title,
                            "اكتب هنا عنوان الرسالة") , 
                        buildFormInput(2, 255, "يكون محتوى الرسالة", body,
                            "اكتب هنا محتوى الرسالة") , 
                      Container( margin: EdgeInsets.only(top:20) , child: Text("اختر هنا القسم الذي تريد ارسال الرسالة اليه" , style: TextStyle(color: Colors.black , fontSize: 16),))  , 

                      new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Radio(
                          value: 0,
                          groupValue: cat,
                          onChanged: _chooseCat,
                        ),
                        new Text(
                          'تكاسي',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 1,
                          groupValue: cat,
                          onChanged: _chooseCat,
                        ),
                        new Text(
                          'مطاعم',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        new Radio(
                          value: 2,
                          groupValue: cat,
                          onChanged: _chooseCat,
                        ),
                        new Text(
                          'اعضاء',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    RaisedButton( color: Theme.of(context).primaryColor , onPressed:sendMessage, textColor: Colors.white ,  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
                      child: Text("ارسال الرسالة"),
                    )) 
                      ])))
            ])));
  }
}
