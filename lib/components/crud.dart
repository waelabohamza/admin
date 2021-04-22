import 'package:admin/const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

String basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'TalabGoUser@58421710942258459:TalabGoPassword@58421710942258459'));
Map<String, String> myheaders = {
  // 'content-type': 'application/json',
  // 'accept': 'application/json',
  'authorization': basicAuth
};

class Crud {
  // var server_name = "10.0.2.2:8080/food";
  // var server_name = "phpcloud-303817.uc.r.appspot.com";
  var server_name = serverName ; 

  readData(String type) async {
    var url;
    if (type == "catfood") {
      url = "https://${server_name}/categories/categories.php?type=0";
    }
    if (type == "cattaxi") {
      url = "https://${server_name}/categories/categories.php?type=1";
    }
    if (type == "restaurants") {
      url = "https://${server_name}/restaurants/restaurants.php";
    }
    if (type == "items") {
      url = "https://${server_name}/items/items.php";
    }
    if (type == "countall") {
      url = "https://${server_name}/countall.php";
    }
    if (type == "users") {
      url = "https://${server_name}/users/users.php";
    }
    if (type == "ordersfood") {
      url = "https://${server_name}/orders/ordersadmin.php";
    }
    if (type == "orderstaxi") {
      url = "https://${server_name}/taxi/orderstaxiadmin.php";
    }
    if (type == "offers") {
      url = "https://${server_name}/offers/offers.php";
    }
    try {
      var response = await http.get(Uri.parse(url));
      print(response.body);
      var responsebody = jsonDecode(response.body);
      return responsebody;
    } catch (e) {
      print("caught error : ");
      print(e);
    }
  }

  readDataWhere(String type, String value) async {
    var url;
    var data;

    if (type == "restaurants") {
      url = "https://${server_name}/restaurants/restaurants.php";
      data = {"resapprove": value};
    }
    if (type == "settings") {
      url = "https://${server_name}/settings/settings.php";
      data = {"id": value};
    }
    if (type == "items") {}
    if (type == "searchcats") {
      url = "https://${server_name}/categories/searchcateories.php";
      data = {"search": value};
    }
    if (type == "searchitems") {
      url = "https://${server_name}/items/searchitems.php";
      data = {"search": value};
    }
    if (type == "searchusers") {
      url = "https://${server_name}/users/searchusers.php";
      data = {"search": value};
    }
    if (type == "searchrestaurants") {
      url = "https://${server_name}/restaurants/searchrestaurants.php";
      data = {"search": value};
    }
    if (type == "taxi") {
      url = "https://${server_name}/taxi/taxi.php";
      data = {"approve": value};
    }
    if (type == "searchtaxi") {
      url = "https://${server_name}/taxi/searchtaxi.php";
      data = {"search": value};
    }

    try {
      var response =
          await http.post(Uri.parse(url), body: data );
      print(response.body);
      var responsebody = jsonDecode(response.body);
      return responsebody;
    } catch (e) {
      print("caught error : ");
      print(e);
    }
  }

  writeData(String type, var data) async {
    var url;
    if (type == "restaurantsapprove") {
      url = "https://${server_name}/restaurants/approverestaurants.php";
    }
    if (type == "restaurantsdelete") {
      url = "https://${server_name}/restaurants/deleterestaurants.php";
    }
    if (type == "deletecategories") {
      url = "https://${server_name}/categories/deletecategories.php";
    }
    if (type == "items") {
      url = "https://${server_name}/items/items.php";
    }
    if (type == "deleteitems") {
      url = "https://${server_name}/items/deleteitems.php";
    }
    if (type == "editsettings") {
      url = "https://${server_name}/settings/editsettings.php";
    }
    if (type == "login") {
      url = "https://${server_name}/auth/login.php";
    }
    if (type == "logout") {
      url = "https://${server_name}/auth/logout.php";
    }
    if (type == "deleteusers") {
      url = "https://${server_name}/users/deleteusers.php";
    }
    if (type == "savelocation") {
      url = "https://${server_name}/auth/res_signup_two.php";
    }
    if (type == "addresturantsthree") {
      url = "https://${server_name}/restaurants/addrestaurantsthree.php";
    }
    if (type == "addresturantsfour") {
      url = "https://${server_name}/restaurants/addrestaurantsfour.php";
    }
    if (type == "transfermoney") {
      url = "https://${server_name}/money/transfermoney.php";
    }
    if (type == "deletetaxi") {
      url = "https://${server_name}/taxi/deletetaxi.php";
    }
    if (type == "approvetaxi") {
      url = "https://${server_name}/taxi/approvetaxi.php";
    }
    if (type == "sendmessage") {
      url = "https://${server_name}/message/sendmessagecat.php";
    }
    if (type == "sendmessagespecfic") {
      url = "https://${server_name}/message/sendmessagespecfic.php";
    }
    if (type == "deleteoffers") {
      url = "https://${server_name}/offers/deleteoffers.php";
    }
    try {
      var response =
          await http.post(Uri.parse(url), body: data);
      print(response.body);
      var responsebody = jsonDecode(response.body);
      return responsebody;
    } catch (e) {
      print("caught error : ");
      print(e);
    }
  }

  checkProblem(email, password, username, phone) async {
    var data = {
      'email': email,
      'password': password,
      'username': username,
      'phone': phone
    };
    var url = "https://${server_name}/users/addusers.php";
    var response =
        await http.post(Uri.parse(url), body: data );
    print(response.body);
  }

  Future addItems(itemname, itemprice, catname, resname, File imagefile) async {
    var stream = new http.ByteStream(imagefile.openRead());
    stream.cast();
    var length = await imagefile.length();

    var uri = Uri.parse("https://${server_name}/items/additems.php");
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(myheaders);
    var multipartFile = new http.MultipartFile("file", stream, length,
        filename: basename(imagefile.path));
    request.fields["item_name"] = itemname;
    request.fields["item_price"] = itemprice;
    request.fields["cat_name"] = catname;
    request.fields["res_name"] = resname;
    request.files.add(multipartFile);
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
    }
  }

  Future editItems(itemid, itemname, itemprice, catname, bool issfile,
      [File imagefile]) async {
    var uri = Uri.parse("https://${server_name}/items/edititems.php");

    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(myheaders);

    if (issfile == true) {
      var stream = new http.ByteStream(imagefile.openRead());
      stream.cast();
      var length = await imagefile.length();
      var multipartFile = new http.MultipartFile("file", stream, length,
          filename: basename(imagefile.path));
      request.files.add(multipartFile);
    }
    request.fields["itemid"] = itemid;
    request.fields["item_name"] = itemname;
    request.fields["item_price"] = itemprice;
    request.fields["cat_name"] = catname;
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
    }
  }

  Future addCategories(
      catname, catnameen, selectedRadio, File imagefile) async {
    var stream = new http.ByteStream(imagefile.openRead());
    stream.cast();
    var length = await imagefile.length();
    var uri = Uri.parse("https://${server_name}/categories/addcategories.php");
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(myheaders);
    var multipartFile = new http.MultipartFile("file", stream, length,
        filename: basename(imagefile.path));
    request.fields["cat_name"] = catname;
    request.fields["cat_name_en"] = catnameen;
    request.fields["type"] = selectedRadio.toString();
    request.files.add(multipartFile);
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
    }
  }

  Future editCategories(catid, catname, categorynameen, bool issfile,
      [File imagefile]) async {
    var uri = Uri.parse("https://${server_name}/categories/editcategories.php");

    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(myheaders);

    if (issfile == true) {
      var stream = new http.ByteStream(imagefile.openRead());
      stream.cast();
      var length = await imagefile.length();
      var multipartFile = new http.MultipartFile("file", stream, length,
          filename: basename(imagefile.path));
      request.files.add(multipartFile);
    }
    request.fields["cat_name"] = catname;
    request.fields["cat_name_en"] = categorynameen;
    request.fields["cat_id"] = catid;
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
    }
  }

  Future addOffers(title, body, File imagefile) async {
    var stream = new http.ByteStream(imagefile.openRead());
    stream.cast();
    var length = await imagefile.length();
    var uri = Uri.parse("https://$server_name/offers/addoffers.php");
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(myheaders);
    var multipartFile = new http.MultipartFile("file", stream, length,
        filename: basename(imagefile.path));
    request.fields["offers_title"] = title;
    request.fields["offers_body"] = body;
    request.files.add(multipartFile);
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
    }
  }

  Future addRestarants(String name, String password, String email, phone,
      File imagelogo, File imagelisence) async {
    var stream = new http.ByteStream(imagelogo.openRead());
    stream.cast();
    var streamtwo = new http.ByteStream(imagelisence.openRead());
    stream.cast();
    var length = await imagelogo.length();
    var lengthtwo = await imagelisence.length();
    var uri = Uri.parse("https://${server_name}/restaurants/addrestaurants.php");
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(myheaders);
    var multipartFile = new http.MultipartFile("file", stream, length,
        filename: basename(imagelogo.path));
    var multipartFileTwo = new http.MultipartFile(
        "filetwo", streamtwo, lengthtwo,
        filename: basename(imagelisence.path));
    // add Data to request
    request.fields["res_name"] = name;
    request.fields["res_password"] = password;
    request.fields["res_email"] = email;
    request.fields["phone"] = phone;
    // add Data to request
    request.files.add(multipartFile);
    request.files.add(multipartFileTwo);
    // Send Request
    var myrequest = await request.send();
    // For get Response Body
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print(response.body);
      return jsonDecode(response.body);
    }
  }

  Future addUsers(email, password, username, phone, File imagefile) async {
    var stream = new http.ByteStream(imagefile.openRead());
    stream.cast();
    var length = await imagefile.length();
    var uri = Uri.parse("https://${server_name}/users/addusers.php");

    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(myheaders);

    var multipartFile = new http.MultipartFile("file", stream, length,
        filename: basename(imagefile.path));
    request.fields["email"] = email;
    request.fields["password"] = password;
    request.fields["username"] = username;
    request.fields["phone"] = phone;

    request.files.add(multipartFile);
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    }
  }

  Future editUsers(username, email, password, phone, id, bool issfile,
      [File imagefile]) async {
    var uri = Uri.parse("https://${server_name}/users/editusers.php");
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(myheaders);
    if (issfile == true) {
      var stream = new http.ByteStream(imagefile.openRead());
      stream.cast();
      var length = await imagefile.length();
      var multipartFile = new http.MultipartFile("file", stream, length,
          filename: basename(imagefile.path));
      request.files.add(multipartFile);
    }
    request.fields["username"] = username;
    request.fields["email"] = email;
    request.fields["password"] = password;
    request.fields["phone"] = phone;
    request.fields["userid"] = id;
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);

    if (myrequest.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      print(jsonDecode(response.body));
    }
  }

  Future addUsersTaxi(email, password, username, phone, File imagefile) async {
    var stream = new http.ByteStream(imagefile.openRead());
    stream.cast();
    var length = await imagefile.length();
    var uri = Uri.parse("https://${server_name}/auth/taxisignup.php");
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(myheaders);

    var multipartFile = new http.MultipartFile("file", stream, length,
        filename: basename(imagefile.path));

    request.fields["email"] = email;
    request.fields["password"] = password;
    request.fields["username"] = username;
    request.fields["phone"] = phone;
    // لانو خاص بالتكسي
    request.fields["role"] = "4";
    request.files.add(multipartFile);
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    }
  }

  Future addTaxitwo(
      String taxiemail,
      String taxiModel,
      String taxiYear,
      String taxiBrand,
      String taxiDescription,
      String taxiPrice,
      File image,
      File imagelisence) async {
    var stream = new http.ByteStream(image.openRead());
    stream.cast();
    var streamtwo = new http.ByteStream(imagelisence.openRead());
    stream.cast();
    var length = await image.length();
    var lengthtwo = await imagelisence.length();
    var uri = Uri.parse("https://${server_name}/taxi/addtaxi.php");
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(myheaders);
    var multipartFile = new http.MultipartFile("file", stream, length,
        filename: basename(image.path));
    var multipartFileTwo = new http.MultipartFile(
        "filetwo", streamtwo, lengthtwo,
        filename: basename(imagelisence.path));
    // add Data to request
    request.fields["email"] = taxiemail;
    request.fields["model"] = taxiModel;
    request.fields["year"] = taxiYear;
    request.fields["brand"] = taxiBrand;
    request.fields["description"] = taxiDescription;
    // add Data to request
    request.files.add(multipartFile);
    request.files.add(multipartFileTwo);
    // Send Request
    var myrequest = await request.send();
    // For get Response Body
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print(response.body);
      return jsonDecode(response.body);
    }
  }

// Start Fremowrk
  
  Future addRequestWithImageOne(url, filename, [File image]) async {
    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(myheaders);

    if (image != null) {
      var length = await image.length();
      var stream = new http.ByteStream(image.openRead());
      stream.cast();
      var multipartFile = new http.MultipartFile(filename, stream, length,
          filename: basename(image.path));
      request.files.add(multipartFile);
    }

    // add Data to request
    // data.forEach((key, value) {
    //   request.fields[key] = value;
    // });
    // add Data to request
    // Send Request
    var myrequest = await request.send();
    // For get Response Body
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print(response.body);
      return jsonDecode(response.body);
    }
  }

  Future addRequestAndImageTwo(
      String url, Map data, File image, File imagetwo) async {
    var stream = new http.ByteStream(image.openRead());
    stream.cast();
    var streamtwo = new http.ByteStream(imagetwo.openRead());
    stream.cast();
    var length = await image.length();
    var lengthtwo = await imagetwo.length();
    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(myheaders);
    var multipartFile = new http.MultipartFile("file", stream, length,
        filename: basename(image.path));
    var multipartFileTwo = new http.MultipartFile(
        "filetwo", streamtwo, lengthtwo,
        filename: basename(imagetwo.path));
    // add Data to request
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    // add Data to request
    request.files.add(multipartFile);
    request.files.add(multipartFileTwo);
    // Send Request
    var myrequest = await request.send();
    // For get Response Body
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print(response.body);
      return jsonDecode(response.body);
    }
  }

  Future editRequestWithoutImage(String url, Map data) async {
    var uri = Uri.parse(url);
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(myheaders);

    // add Data to request
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    // Send Request
    var myrequest = await request.send();
    // For get Response Body
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print(response.body);
      return jsonDecode(response.body);
    }
  }
}
