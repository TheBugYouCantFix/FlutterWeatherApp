import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    ),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    duration: const Duration(seconds: 1),
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height * 0.1,
      left: 50,
      right: 50,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
