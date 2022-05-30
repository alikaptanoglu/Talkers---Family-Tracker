import 'package:flutter/material.dart';

class Space {

  SizedBox spaceHeight(double value) => SizedBox(height: value,);
  SizedBox spaceWidth(double value) => SizedBox(width: value,);
  
  Expanded expandedSpace = const Expanded(child: SizedBox());

}

