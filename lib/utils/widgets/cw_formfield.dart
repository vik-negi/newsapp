import 'package:flutter/material.dart';
import 'package:news/resourses/r.dart';
import 'package:news/utils/constants.dart';
import 'package:news/utils/cw_text.dart';
import 'package:news/utils/my_widget.dart';

class CWFormField extends StatefulWidget {
  const CWFormField({
    super.key,
    required this.controller,
    this.name,
    this.validator,
    this.hint = "",
    this.useBlackColor = false,
    this.hintColor,
  });

  final TextEditingController controller;
  final String? name;
  final String hint;
  final bool useBlackColor;
  final Color? hintColor;
  final String? Function(String?)? validator;

  @override
  State<CWFormField> createState() => _CWFormFieldState();
}

class _CWFormFieldState extends State<CWFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(
        fontFamily: Constants.fontFamily,
      ),
      validator: widget.validator,
      scrollPadding: EdgeInsets.zero,
      decoration: InputDecoration(
        hintText: widget.hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: R.color.white,
        filled: true,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,

        hintStyle: TextStyle(
          fontFamily: Constants.fontFamily,
          height: 21 / 14,
          color: R.color.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: InputBorder.none,

        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: R.color.white),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: R.color.white),
        // ),
      ),
    );
  }
}
