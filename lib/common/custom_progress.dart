import 'package:flutter/material.dart';
import 'package:one_lead/constants/color_code.dart';
Widget customProgress(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height / 1.3,
    child: const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ColorCodes.primary),
      ),
    ),
  );
}