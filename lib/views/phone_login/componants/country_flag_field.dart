import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/my_colors.dart';
import 'package:flutter_maps/widgets/custom_text.dart';

class BuildCountryFlagField extends StatelessWidget {
  const BuildCountryFlagField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.lightGrey),
          borderRadius: BorderRadius.circular(6),
        ),
        child: CustomText(text: generateCountryFlag() + '   +2', fontsize: 22),
      ),
    );
  }
}

String generateCountryFlag() {
  String countryCode = 'eg';
  return countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0).codeUnitAt(0) + 127397));
}
