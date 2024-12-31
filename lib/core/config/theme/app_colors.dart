import 'package:flutter/material.dart';

class AppColors {
  // Colores primarios
  static const Color primary = Color(0xff190019);
  static const Color primaryLight = Color(0xFF190019);
  static const Color primaryDark = Color(0xffFBE4D8);

  // Colores secundarios
  static const Color secondary = Color(0xff2B124c);
  static const Color secondaryLight = Color(0xffDFB6B2);
  static const Color secondaryDark = Color(0xff522B5B);

  // Colores neutros
  static const Color background = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF1E1E1E);
  static const Color text = Color(0xFF333333);
  static const Color textLight = Color(0xFF666666);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Colores de estado
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);

  // Colores para modo oscuro
  static const ColorScheme darkColorScheme = ColorScheme.dark(
    primary: primary,
    secondary: secondary,
    surface: Color(0xFF121212),
    error: error,
  );

  // Colores para modo claro
  static const ColorScheme lightColorScheme = ColorScheme.light(
    primary: primary,
    secondary: secondary,
    surface: Colors.white,
    error: error,
  );

  static const Color ligthBorderColor = Color(0xFFBEBFC0);
}
