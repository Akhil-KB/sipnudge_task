import 'package:flutter/material.dart';

class AppColor {
  static const bottomNavColor = Color(0xff2B2536);
  static final bottomNavBorderGradient = LinearGradient(
    colors: const [Color(0xFF3F3F3F), Color(0xFFFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static final scaffoldBgGradient = LinearGradient(
    colors: const [Color(0xFFB586BE), Color(0xFF131313)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const selectedTabBgColor = Color(0xFFA964E0);
  static const tabBarBgColor = Color(0xFFFFFFFF);
  static const unselectedTabFontColor = Color(0xFF212121);
  static const tabContainerColor = Color(0xFF907396);
  static const barGradientColors = [
    const Color(0xFF7B2FF7),
    const Color(0xFF9C4DFF),
    const Color(0xFFB770FF),
  ];
}
