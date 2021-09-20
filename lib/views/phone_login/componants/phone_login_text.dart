import 'package:flutter/material.dart';
import 'package:flutter_maps/widgets/custom_text.dart';

class BuildLoginText extends StatelessWidget {
  const BuildLoginText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        CustomText(
          text: 'What is your phone number ?',
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 30),
        CustomText(
          text: 'Please enter your phone number to verify your account ',
          color: Colors.grey,
          fontsize: 20,
        ),
      ],
    );
  }
}
