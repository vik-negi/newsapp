import 'package:flutter/material.dart';
import 'package:news/utils/constants.dart';

void showSnackbar(BuildContext context, String text) {
  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    content: Container(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xFF3F3F3F),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7.5),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: Constants.fontFamily,
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    ),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(bottom: 0),
    elevation: 0,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
