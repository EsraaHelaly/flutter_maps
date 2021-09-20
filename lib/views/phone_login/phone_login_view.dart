import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/my_colors.dart';
import 'package:flutter_maps/router.dart';
import 'package:flutter_maps/views/otp/otp_view.dart';
import 'package:flutter_maps/views/phone_login/cubit/phoneauth_cubit.dart';
import 'package:flutter_maps/widgets/custom_button.dart';

import 'componants/country_flag_field.dart';
import 'componants/phone_login_text.dart';
import 'componants/phone_number_filed.dart';
import 'cubit/phoneauth_cubit.dart';
import 'package:flutter_maps/views/phone_login/cubit/phoneauth_state.dart';

// ignore: must_be_immutable
class PhoneLoginView extends StatelessWidget {
  PhoneLoginView({Key key}) : super(key: key);
  final GlobalKey<FormState> _key = GlobalKey();
  String phoneNumber;
  @override
  Widget build(BuildContext context) {
    String phoneNumber;

    return SafeArea(
      child: BlocProvider(
        create: (context) => PhoneAuthCubit(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: _key,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BuildLoginText(),
                  const SizedBox(height: 150),
                  Row(
                    children: [
                      BuildCountryFlagField(),
                      SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: MyColors.blue),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextFormField(
                            autofocus: true,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            style: const TextStyle(
                                fontSize: 18, letterSpacing: 2.0),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'please enter your phone number';
                              } else if (value.length < 11) {
                                return 'invalid number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              phoneNumber = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
                    listenWhen: (previous, current) {
                      return previous != current;
                    },
                    listener: (context, state) {
                      if (state is PhoneAuthLoading) {
                        const Center(child: CircularProgressIndicator());
                      }

                      if (state is PhoneAuthSucsess) {
                        RouterController.push(
                            context, OtpView(phoneNumber: phoneNumber));
                      }
                      if (state is PhoneAuthError) {
                        String errorMsg = (state).error;
                        print(errorMsg);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMsg),
                            backgroundColor: Colors.black,
                            duration: const Duration(seconds: 15),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        text: 'Next',
                        press: () {
                          const Center(child: CircularProgressIndicator());
                          if (_key.currentState.validate()) {
                            _key.currentState.save();
                            PhoneAuthCubit.get(context)
                                .submitPhoneNumber(phoneNumber);
                          } else {
                            return;
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
