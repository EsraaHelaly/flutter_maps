import 'package:flutter/material.dart';

class RouterController {
  static push(BuildContext context, view) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => view));

  static pushReplacement(BuildContext context, view) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => view));
}
