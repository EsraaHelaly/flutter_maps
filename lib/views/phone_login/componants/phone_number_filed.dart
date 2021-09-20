import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/my_colors.dart';
import 'package:flutter_maps/views/phone_login/cubit/phoneauth_cubit.dart';

// ignore: must_be_immutable
class BuildPhoneField extends StatelessWidget {
  const BuildPhoneField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.blue),
          borderRadius: BorderRadius.circular(6),
        ),
        child: TextFormField(
          autofocus: true,
          decoration: const InputDecoration(border: InputBorder.none),
          style: const TextStyle(fontSize: 18, letterSpacing: 2.0),
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
          onSaved: (value) {},
        ),
      ),
    );
  }
}
