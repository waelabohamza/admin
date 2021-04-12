import 'package:admin/pages/restaurants/addrestaurantsthree.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:admin/components/alert.dart';
import 'dart:async';
import 'package:admin/components/crud.dart';
 

class AddRestaurantsTwo extends StatefulWidget {
  final res_email ; 

  AddRestaurantsTwo({Key key ,  this.res_email}) : super(key: key);

  @override
  _AddRestaurantsTwoState createState() => _AddRestaurantsTwoState();
}

class _AddRestaurantsTwoState extends State<AddRestaurantsTwo> {
  double lat = null;
  double long = null;
  var country ; 
  var street ; 
  var area ; 

  // Start Map

  Completer<GoogleMapController> _controller = Completer();

  Crud crud = new Crud() ; 

  List<Marker> markers = [];

  // Save Lat Long in database 

  saveLocation() async {
    if (lat == null || long == null ) {
      
     print("===========================") ; 
     print(country) ;
     print(long) ;
     print(lat) ;
     print("faild") ;
     return showdialogall(context, "الرجاء تحديد مكان امطعم على الخريطة", "تنبيه")  ; 
    }
     print("===========================") ; 
     print("success") ;
     print(country) ;
     print(widget.res_email) ; 
     print(lat) ; 
     print(long) ; 
    var data = {"lat" : lat.toString() , "long" : long.toString() , "res_email" :widget.res_email} ; 
    var responsebody = await crud.writeData("savelocation", data) ; 
    if (responsebody['status'] == "success") {
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return AddRestaurantsThree(resemail: widget.res_email ) ; 
            })) ; 
    }

  }

  // End Map

  @override
  void initState() {
    getLocation();
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mdh = MediaQuery.of(context).size.height;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(' الرجاء تحديد موضع المطعم على الخريطة  '),
            centerTitle: true,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            padding: EdgeInsets.all(20),
            height: 80,
            child: MaterialButton(
              child: Text("متابعة",
                  style: TextStyle(color: Colors.red, fontSize: 20)),
              onPressed: () {
                // Navigator.of(context).pushNamed("signupthree" , arguments: { "country" : country , "area" : area , "street" : street }) ; 
               saveLocation() ; 
              },
              color: Colors.white,
            ),
          ),
          body: Column(
            children: [
              lat == null
                  ? SizedBox(
                      height: 10,
                    )
                  : Container(
                      height: mdh - 170,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition:
                            CameraPosition(target: LatLng(lat, long), zoom: 10),
                        markers: markers.toSet(),
                        onTap: _handleTap,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      )),
            ],
          ),
        ));
  }

  _handleTap(LatLng tappedpoint) {
    setState(() {
      markers = [];
      markers.add(
        Marker(
            markerId: MarkerId(tappedpoint.toString()),
            infoWindow: InfoWindow(title: tappedpoint.toString()),
            position: tappedpoint,
            draggable: true,
            onDragEnd: (ondragend) {
              print(ondragend);
            }),
      );
      lat = tappedpoint.latitude ; 
      long = tappedpoint.longitude ; 
    });
    
    // print(tappedpoint);
  }

    // Start Geolocation

  getLocation() async {
    Position position =
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = position.latitude;
      long = position.longitude;
      // print("==============================");
      // print(lat);
      // print("=========================");
      markers.add(Marker(
          markerId: MarkerId(lat.toString()), position: LatLng(lat, long)));
    });
     
    print("=============================================================") ; 
    print(widget.res_email) ; 
    print("=============================================================") ; 
  }

  // End GeoLocation

  // Start GeoCooding

 

  // End GeoCooding
}
