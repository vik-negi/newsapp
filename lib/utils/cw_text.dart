import 'package:flutter/material.dart';

class CWText extends StatefulWidget {
  const CWText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.lineHeight,
    this.fontfamily,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.useBlackColor = false,
    this.fontStyle,
    this.maxLines,
  });

  final String text;
  final double fontSize;
  final double? lineHeight;
  final String? fontfamily;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final useBlackColor;
  final FontStyle? fontStyle;
  final int? maxLines;

  @override
  State<CWText> createState() => _CWTextState();
}

class _CWTextState extends State<CWText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: widget.fontWeight ?? FontWeight.w700,
          fontSize: widget.fontSize,
          fontStyle: widget.fontStyle,
          overflow: TextOverflow.ellipsis,
          height: widget.lineHeight == null
              ? null
              : (widget.lineHeight! / widget.fontSize),
          color: (widget.color) ??
              (Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black)),
      // TextStyle(
      //   fontSize: widget.fontSize,
      //   fontFamily: widget.fontfamily,
      //   fontWeight: widget.fontWeight,
      // ),
    );
  }
}
