import 'package:flutter/material.dart';
import '../../main.dart';
import '../responsive/responsive.dart';

class SnackbarDialog {
  
  final messageFailedOne = _buildSnackbar(parsedJson['snackbarfailedmessage4'], false);
  final messageFailedTwo = _buildSnackbar('Something went wrong', false);

}

SnackBar _buildSnackbar(String text, bool ok,) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 50),
      backgroundColor: Colors.transparent,
      content: Container(
        width: SizeConfig.screenWidth! - 60,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        height: 50,
        child: Column(
        children: [
          Center(child: FittedBox(child: Text(text, textAlign: TextAlign.center,style: const TextStyle(color: Colors.white, fontSize: 20)))),
        ],
      )));
  }