import 'package:flutter/material.dart';

Color choiceColor(String color){
  if(color=="blue") {
    return Colors.blue;
  }
  if(color=="orange") {
    return Colors.orange;
  }
  if(color=="yellow") {
    return Colors.yellow;
  }
  if(color=="red") {
    return Colors.red;
  }
  return Colors.black;
}