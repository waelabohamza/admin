import 'package:admin/components/crud.dart';
import 'package:admin/pages/categories/categorieslist.dart';
import 'package:admin/pages/items/itemslist.dart';
import 'package:admin/pages/restaurants/restaurantslist.dart';
import 'package:admin/pages/taxi/taxilist.dart';
import 'package:admin/pages/users/userslist.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<Future<Widget>> {
  List<dynamic> list;
  final type;
  final mdw;

  DataSearch({this.type, this.mdw});

  Crud crud = new Crud();
  @override
  List<Widget> buildActions(BuildContext context) {
    // Action for AppBar
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon Leading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    return Text("yes");
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searchers for something
    if (query.isEmpty) {
      return Center(
        child: Stack(
          children: [
            Positioned(
                left: mdw - 85 / 100 * mdw,
                top: mdw - 50 / 100 * mdw,
                child: Image.asset(
                  "images/search.png",
                  width: mdw,
                  height: mdw,
                ))
          ],
        ),
      );
    } else {
      return FutureBuilder(
        future: type == "categories"
            ? crud.readDataWhere("searchcats", query.toString())
            : type == "items"
                ? crud.readDataWhere("searchitems", query.toString())
                : type == "users" ? 
                  crud.readDataWhere("searchusers", query.toString()) : type == "restuarants" ? 
                    crud.readDataWhere("searchrestaurants", query.toString()) : type == "taxi" ? 
                    crud.readDataWhere("searchtaxi", query.toString()) : "" 
                 ,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data[0] == "faild") {
                return Image.asset("images/notfounditem.jpg") ; 
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  if (type == "categories") {
                    return CategoryList(
                      id: snapshot.data[i]['cat_id'],
                      name: snapshot.data[i]['cat_name'],
                      image: snapshot.data[i]['cat_photo'],
                    );
                  } else if (type == "items") {
                          return ItemsList(
                            id: snapshot.data[i]['item_id'],
                            name: snapshot.data[i]['item_name'],
                            price: snapshot.data[i]['item_price'],
                            itemcat: snapshot.data[i]['cat_name'],
                            image: snapshot.data[i]['item_image'],
                            itemcatid: snapshot.data[i]['cat_id'],
                          );
                  } else if (type == "users") {
                     return UsersList(listusers: snapshot.data[i],) ; 
                  }else if (type == "restuarants") {
                    return  RestaurantsList(restaurantslist: snapshot.data[i],) ; 
                  }else if (type == "taxi") {
                    return  TaxiList(crud: crud,taxilist: snapshot.data[i]) ; 
                  }
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      );
    }
  }
}
