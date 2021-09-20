import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/router.dart';
import 'package:flutter_maps/views/phone_login/cubit/phoneauth_cubit.dart';
import 'package:flutter_maps/views/phone_login/phone_login_view.dart';
import 'package:flutter_maps/widgets/custom_button.dart';

class MapsView extends StatelessWidget {
  const MapsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthCubit(),
      child: Scaffold(
        body: Center(
          child: CustomButton(
            text: 'LogOut',
            press: () async {
              await PhoneAuthCubit.get(context).signOut();
              RouterController.pushReplacement(context, PhoneLoginView());
            },
          ),
        ),
      ),
    );
  }
}
