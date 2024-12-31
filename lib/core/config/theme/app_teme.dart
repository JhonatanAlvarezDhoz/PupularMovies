import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // Tema claro
  static ThemeData get lightTheme {
    return ThemeData(
      // Esquema de colores
      colorScheme: AppColors.lightColorScheme,

      // Configuración de AppBar
      appBarTheme: const AppBarTheme(
        color: AppColors.primary,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Configuración de Text
      textTheme: const TextTheme(
        // Estilos de texto predeterminados
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.text,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.textLight,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.textLight,
        ),
      ),

      // Configuración de botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Configuración de Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.primary.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColors.primary.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
      ),

      // Otras configuraciones
      scaffoldBackgroundColor: AppColors.background,
      dividerColor: Colors.grey.shade300,
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Tema oscuro
  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: AppColors.darkColorScheme,

      // Puedes personalizar aún más el tema oscuro
      appBarTheme: const AppBarTheme(
        color: AppColors.primaryDark,
        elevation: 0,
      ),

      // Resto de configuraciones similares al tema claro
      // pero con colores adaptados al modo oscuro
      scaffoldBackgroundColor: AppColors.backgroundDark,
    );
  }

  // Método para crear temas personalizados
  static ThemeData createCustomTheme({
    Color? primaryColor,
    Brightness brightness = Brightness.light,
  }) {
    final colorScheme = brightness == Brightness.light
        ? AppColors.lightColorScheme.copyWith(primary: primaryColor)
        : AppColors.darkColorScheme.copyWith(primary: primaryColor);

    return ThemeData(
      colorScheme: colorScheme,
      brightness: brightness,
      // Resto de configuraciones
    );
  }
}
