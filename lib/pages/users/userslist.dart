import 'package:admin/components/crud.dart';
import 'package:admin/pages/message/specficmessage.dart';
import 'package:admin/pages/users/editusers.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UsersList extends StatelessWidget {
  final listusers;
  UsersList({this.listusers});
  Crud crud = new Crud();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return EditUsers(
                userid: listusers['user_id'],
                username: listusers['username'],
                password: listusers['password'],
                email: listusers['email'],
                phone: listusers['user_phone']);
          }));
        },
        child: Card(
            child: Row(
          children: [
            Expanded(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: listusers['user_image'] == null ||
                        listusers['user_image'] == ""
                    ? CachedNetworkImageProvider(
                        "http://${crud.server_name}/upload/users/avatar.png")
                    : CachedNetworkImageProvider(
                        "http://${crud.server_name}/upload/users/${listusers['user_image']}"),
              ),
              flex: 2,
            ),
            Expanded(
              child: ListTile(
                title: Text(" ${listusers['username']} "),
                subtitle: Text(" ${listusers['email']} "),
                trailing: IconButton(icon: Icon(Icons.message),onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return SpecficMessage(type: "user" , id: listusers['user_id']) ; 
                   })) ; 
                },),
              ),
              flex: 3,
            ),
          ],
        )),
      ),
    );
  }
}
