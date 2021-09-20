// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/my_colors.dart';
import 'package:flutter_maps/views/maps/maps_view.dart';
import 'package:flutter_maps/views/phone_login/cubit/phoneauth_cubit.dart';
import 'package:flutter_maps/views/phone_login/cubit/phoneauth_state.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../router.dart';

class OtpView extends StatelessWidget {
  OtpView({Key key, this.phoneNumber}) : super(key: key);
  TextEditingController textEditingController = TextEditingController();
  String otpCode;
  final phoneNumber;

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify your phone number',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
              text: 'Enter your 6 digit code numbers sent to ',
              style: TextStyle(color: Colors.black, fontSize: 18, height: 1.4),
              children: <TextSpan>[
                TextSpan(
                  text: '$phoneNumber',
                  style: TextStyle(color: MyColors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );

    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  Widget _buildPinCodeFields(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
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
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        enableActiveFill: true,
        controller: textEditingController,
        onCompleted: (submitedCode) {
          otpCode = submitedCode;
          print("Completed");
        },
        onChanged: (value) {
          print(value);
        },
      ),
    );
  }

  Widget _buildVrifyButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          showProgressIndicator(context);
          BlocProvider.of<PhoneAuthCubit>(context).submitOtp(otpCode);
        },
        child: Text(
          'Verify',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(110, 50),
          primary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneVerificationBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is PhoneAuthLoading) {
          showProgressIndicator(context);
        }

        if (state is PhoneOtpSucsess) {
          Navigator.pop(context);
          RouterController.pushReplacement(context, const MapsView());
        }

        if (state is PhoneAuthError) {
          //Navigator.pop(context);
          String errorMsg = (state).error;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 5),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthCubit(),
      child: BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 32, vertical: 88),
                child: Column(
                  children: [
                    _buildIntroTexts(),
                    SizedBox(
                      height: 88,
                    ),
                    _buildPinCodeFields(context),
                    SizedBox(
                      height: 60,
                    ),
                    _buildVrifyButton(context),
                    _buildPhoneVerificationBloc(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



















// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_maps/constants/my_colors.dart';
// import 'package:flutter_maps/views/maps/maps_view.dart';
// import 'package:flutter_maps/views/phone_login/cubit/phoneauth_cubit.dart';
// import 'package:flutter_maps/widgets/custom_button.dart';
// import 'package:flutter_maps/views/phone_login/cubit/phoneauth_state.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// import '../../router.dart';
// import 'componants/otp_intro_text.dart';
// import 'componants/pin_code_text_field.dart';

// // ignore: must_be_immutable
// class OtpView extends StatelessWidget {
//   OtpView({Key key, this.phoneNumber}) : super(key: key);

//   final String phoneNumber;
//   String otpCode;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               BuildOtpIntroText(phoneNumber: phoneNumber),
//               const SizedBox(height: 150),
//               PinCodeTextField(
//                 appContext: context,
//                 length: 6,
//                 obscureText: false,
//                 cursorColor: Colors.black,
//                 keyboardType: TextInputType.number,
//                 animationType: AnimationType.fade,
//                 pinTheme: PinTheme(
//                   shape: PinCodeFieldShape.box,
//                   borderRadius: BorderRadius.circular(6),
//                   fieldHeight: 50,
//                   fieldWidth: 40,
//                   borderWidth: 1,
//                   activeColor: MyColors.blue,
//                   inactiveColor: MyColors.blue,
//                   inactiveFillColor: Colors.white,
//                   activeFillColor: MyColors.lightBlue,
//                   selectedColor: MyColors.blue,
//                   selectedFillColor: Colors.white,
//                 ),
//                 animationDuration: const Duration(milliseconds: 300),
//                 backgroundColor: Colors.white,
//                 enableActiveFill: true,
//                 onCompleted: (code) {
//                   otpCode = code;
//                 },
//                 onChanged: (value) {},
//               ),
//               const SizedBox(height: 80),
//               BlocProvider(
//                 create: (context) => PhoneAuthCubit(),
//                 child: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
//                   listenWhen: (previous, current) {
//                     return previous != current;
//                   },
//                   listener: (context, state) {
//                     if (state is PhoneAuthLoading) {
//                       const LinearProgressIndicator();
//                     }

//                     if (state is PhoneOtpSucsess) {
//                       RouterController.pushReplacement(
//                           context, const MapsView());
//                     }
//                     if (state is PhoneAuthError) {
//                       String errorMsg = (state).error;
//                       print('otp error =={$errorMsg.toString()}');

//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text(errorMsg),
//                         backgroundColor: Colors.black,
//                         duration: const Duration(seconds: 3),
//                       ));
//                     }
//                   },
//                   builder: (context, state) {
//                     return CustomButton(
//                       text: 'Verify',
//                       press: () {
//                         const LinearProgressIndicator();
//                         PhoneAuthCubit.get(context).submitOtp(otpCode);
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
