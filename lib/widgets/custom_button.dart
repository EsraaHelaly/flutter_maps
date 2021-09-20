import 'dart:ui';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.press,
    this.alignment = Alignment.centerRight,
    this.text,
    this.fontSize = 22,
    this.color = Colors.black,
    this.width = 110,
    this.height = 50,
  }) : super(key: key);
  final Function press;
  final Alignment alignment;
  final String text;
  final double fontSize;
  final double width;
  final double height;

  final Color color;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ElevatedButton(
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height),
          primary: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }
}
