import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xffFE4545);
  static const primaryShadeColor = Color(0xffFFEFEF);
  static const secondaryTextColor = Color(0xff7E7E7E);
  static const borderColor = Color(0xffE9E9E9);

  // Linear Gradient
  static const LinearGradient primaryDarkGradient = LinearGradient(
    colors: [Color(0xffE34E2F), Color(0xffE23851)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient primaryBgGradient = LinearGradient(
    colors: [Color(0xffFF7304), Color(0xffFB2A77)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient goldenGradient = LinearGradient(
    colors: [Color(0xffFFAA04), Color(0xffFB9B2A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient goldenGradient2 = LinearGradient(
    colors: [Color(0xffFE9C13), Color(0xffFB9428)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
