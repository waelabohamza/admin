import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  getData() async {
    // var url = "https://jsonplaceholder.typicode.com/posts";

    var url = "http://talabgo.com/api/categories/categories.php";

    print(url);

    var response = await http.get(Uri.parse(url));

    print(response.body) ;

    // var respnsebody = json.decode(response.body);

    // print(respnsebody);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Container(),
    );
  }
}
