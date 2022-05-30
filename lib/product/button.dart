import 'package:flutter/material.dart';
import '../responsive/responsive.dart';

Container getPremiumButton(String text) {
    return Container(height: 60, decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(17)),child: Center(child: Text(text,style: TextStyle(color: Colors.white,fontSize: SizeConfig().fontSize(22,20)),),));
  }