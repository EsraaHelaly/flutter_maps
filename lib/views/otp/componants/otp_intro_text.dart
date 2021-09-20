import 'package:flutter/material.dart';
import 'package:flutter_maps/widgets/custom_text.dart';

class BuildOtpIntroText extends StatelessWidget {
  const BuildOtpIntroText({
    Key key,
    this.phoneNumber,
  }) : super(key: key);
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Verify your phone number',
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 30),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: "Enter your 6 digit number sent to this number   ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              TextSpan(
                text: '+2$phoneNumber',
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
