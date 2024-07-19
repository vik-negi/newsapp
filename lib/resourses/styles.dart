// Flutter imports:
import 'package:flutter/material.dart';
import 'package:news/utils/constants.dart';

class ResourceStyles {
  TextStyle get fontPoppins =>
      TextStyle(fontFamily: Constants.fontFamily, color: Colors.black);

  final TextStyle fz12 = const TextStyle(fontSize: 12);
  final TextStyle fz13 = const TextStyle(fontSize: 13);
  final TextStyle fz14 = const TextStyle(fontSize: 14);
  final TextStyle fz15 = const TextStyle(fontSize: 15);
  final TextStyle fz16 = const TextStyle(fontSize: 16);
  final TextStyle fz18 = const TextStyle(fontSize: 18);
  final TextStyle fz20 = const TextStyle(fontSize: 20);
  final TextStyle fz22 = const TextStyle(fontSize: 22);
  final TextStyle fz24 = const TextStyle(fontSize: 24);

  TextStyle fw300 = const TextStyle(fontWeight: FontWeight.w300);
  TextStyle fw400 = const TextStyle(fontWeight: FontWeight.w400);
  TextStyle fw500 = const TextStyle(fontWeight: FontWeight.w500);
  TextStyle fw600 = const TextStyle(fontWeight: FontWeight.w600);
  TextStyle fw700 = const TextStyle(fontWeight: FontWeight.w700);

  TextStyle get fz12Fw400 => fz12.merge(fw400);
  TextStyle get fz14Fw400 => fz14.merge(fw400);
  TextStyle get fz16Fw400 => fz16.merge(fw400);

  TextStyle get fz12Fw500 => fz12.merge(fw500);
  TextStyle get fz12Fw600 => fz12.merge(fw600);
  TextStyle get fz12Fw700 => fz12.merge(fw700);
  TextStyle get fz14Fw300 => fz14.merge(fw300);
  TextStyle get fz14Fw500 => fz14.merge(fw500);
  TextStyle get fz14Fw600 => fz14.merge(fw600);
  TextStyle get fz14Fw700 => fz14.merge(fw700);
  TextStyle get fz15Fw500 => fz15.merge(fw500);

  TextStyle get fz16Fw500 => fz16.merge(fw500);
  TextStyle get fz16Fw600 => fz14.merge(fw600);
  TextStyle get fz16Fw700 => fz16.merge(fw700);
  TextStyle get fz18Fw500 => fz18.merge(fw500);
  TextStyle get fz18Fw600 => fz18.merge(fw600);
  TextStyle get fz18Fw700 => fz18.merge(fw700);
  TextStyle get fz20Fw500 => fz20.merge(fw500);
  TextStyle get fz20Fw700 => fz20.merge(fw700);
  TextStyle get fz24Fw500 => fz24.merge(fw500);
  TextStyle get fz24Fw700 => fz24.merge(fw700);
  TextStyle get fz15Fw600 => fz15.merge(fw600);
  TextStyle get fz15Fw700 => fz15.merge(fw700);
}
