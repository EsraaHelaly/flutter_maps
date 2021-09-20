import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontsize;
  final Color color;

  final int maxline;
  final FontWeight fontWeight;

  const CustomText({
    Key key,
    this.text = "",
    this.fontsize = 30,
    this.color = Colors.black,
    this.maxline,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: fontWeight,
      ),
      maxLines: maxline,
    );
  }
}
