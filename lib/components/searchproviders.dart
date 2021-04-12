import 'package:flutter/cupertino.dart';

class SearchProvider with ChangeNotifier {
 var searchstring  = "1" ; 
 changeSearchString(val) {
   searchstring = val  ; 
 }
}