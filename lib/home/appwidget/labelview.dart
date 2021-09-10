import 'package:flutter/material.dart';

class LabelView extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color backgroundColor;
  LabelView(
      {Key? key,
      required this.label,
      required this.textColor,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: textColor),
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
            child: Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
        )),
      ),
    );
  }
}
