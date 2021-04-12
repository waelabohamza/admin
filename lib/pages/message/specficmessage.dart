import 'package:admin/components/alert.dart';
import 'package:admin/components/buildforminput.dart';
import 'package:admin/components/crud.dart';
import 'package:flutter/material.dart';

class SpecficMessage extends StatefulWidget {
  final type  ; 
  final id ; 
  SpecficMessage({Key key , this.type , this.id}) : super(key: key);

  @override
  _SpecficMessageState createState() => _SpecficMessageState();
}

class _SpecficMessageState extends State<SpecficMessage> {

  Crud crud  = new Crud() ; 
  var cat ; 

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  TextEditingController title = new TextEditingController();
  TextEditingController body = new TextEditingController();


  @override
  void initState() { 
    super.initState();
    cat  = widget.type == "user" ?  "2" :   widget.type == "taxi" ? "0" : widget.type == "res" ? "1"  : null ; 
  } 

 
  sendMessage() async{
      String mytitle  = "خطأ" ; 
      String mycontent = "يجب تحديد القسم الذي تريد ارسال الرسالة اليه" ; 
      if (cat == null) return showdialogall(context, mytitle, mycontent) ; 
       var formdata = formstate.currentState ;
       if (formdata.validate()) {
          showLoading(context) ;
            Map data  ;  
          if (cat == "2") {
             data = {"title"  : title.text   ,  "body" : body.text ,  "cat" :  "2" , "userid" : widget.id.toString()}; 
          } 
          if (cat == "1") {
             data = {"title"  : title.text   ,  "body" : body.text ,  "cat" :  "1" , "resid" : widget.id.toString()}; 
          }
           if (cat == "0") {
             data = {"title"  : title.text   ,  "body" : body.text ,  "cat" :  "0" , "taxiid" : widget.id.toString()}; 
          }
          await crud.writeData("sendmessagespecfic", data) ; 
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
                   
 
                    RaisedButton( color: Theme.of(context).primaryColor , onPressed:sendMessage, textColor: Colors.white ,  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
                      child: Text("ارسال الرسالة"),
                    )) 
                      ])))
            ])));
  }
}
