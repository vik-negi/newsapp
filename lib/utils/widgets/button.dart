import 'package:flutter/material.dart';
import 'package:news/resourses/r.dart';
import 'package:news/utils/cw_text.dart';
import 'package:news/utils/my_widget.dart';

class CWButton extends StatelessWidget {
  const CWButton({
    super.key,
    this.ontap,
    required this.text,
    this.preTextWidget,
    this.textColor,
    this.bgColor,
    this.isLoading = false,
    this.width,
  });

  final Function()? ontap;
  final String text;
  final Widget? preTextWidget;
  final Color? bgColor;
  final Color? textColor;
  final bool isLoading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : ontap,
      child: Container(
        width: width ?? double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: bgColor ?? R.color.myBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (preTextWidget != null) ...[
                    preTextWidget!,
                    hSpacer(6),
                  ],
                  CWText(
                    text: text,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ],
              ),
      ),
    );
  }
}
