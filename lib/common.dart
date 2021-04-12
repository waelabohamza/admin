import "package:flutter/material.dart";
class Common with ChangeNotifier {
bool showpass = true   ; 
changeShowPass(){
  showpass = !showpass  ; 
  notifyListeners() ;  
}
   
}
