import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/my_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class BuildPinCodeTextField extends StatelessWidget {
  BuildPinCodeTextField({
    Key key,
    this.otpCode,
  }) : super(key: key);
  String otpCode;
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(6),
        fieldHeight: 50,
        fieldWidth: 40,
        borderWidth: 1,
        activeColor: MyColors.blue,
        inactiveColor: MyColors.blue,
        inactiveFillColor: Colors.white,
        activeFillColor: MyColors.lightBlue,
        selectedColor: MyColors.blue,
        selectedFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      enableActiveFill: true,
      onCompleted: (code) {
        otpCode = code;
      },
      onChanged: (value) {},
    );
  }
}
