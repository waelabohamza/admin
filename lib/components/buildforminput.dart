import 'package:admin/components/valid.dart';
import 'package:flutter/material.dart';

TextFormField buildFormInput(min  , max    , textvalid ,  mycontrol  , label ){
  return TextFormField(
    controller: mycontrol,
    validator: (val) {
     return validInput(val, min, max, textvalid) ; 
    },
    maxLength: max,
    minLines: 1,
    maxLines: 10,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.category),
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      
    ),
  );
}
