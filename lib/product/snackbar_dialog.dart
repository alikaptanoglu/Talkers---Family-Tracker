import 'package:flutter/material.dart';
import '../../main.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();


class SnackbarDialog {
  final messageSuccess =  SnackBar(
    backgroundColor: Colors.white,
    content: Text(parsedJson['success'],textAlign: TextAlign.center, style: const TextStyle(color: Colors.black)),
    duration: const Duration(seconds: 2),
  );

  final messageFailedOne = _buildSnackbar(parsedJson['snackbarfailedmessage1']);
  final messageFailedTwo = _buildSnackbar(parsedJson['snackbarfailedmessage2']);
  final messageFailedThree = _buildSnackbar(parsedJson['snackbarfailedmessage3']);
  final messageFailedFour = _buildSnackbar(parsedJson['snackbarfailedmessage4']);

}

SnackBar _buildSnackbar(String text) {
    return SnackBar(
                                backgroundColor: Colors.white,
                                duration: const Duration(seconds: 1),
                                content: Text(text, textAlign: TextAlign.center,style: const TextStyle(color: Colors.black, fontSize: 15)));
  }