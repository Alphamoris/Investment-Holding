import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1A73E8);
  static const Color primaryDarkColor = Color(0xFF0D47A1);
  static const Color primaryLightColor = Color(0xFF4285F4);
  static const Color secondaryColor = Color(0xFF34A853);
  static const Color accentColor = Color(0xFFFF6F00);
  
  static const Color errorColor = Color(0xFFEA4335);
  static const Color successColor = Color(0xFF34A853);
  static const Color warningColor = Color(0xFFFBBC04);
  static const Color infoColor = Color(0xFF4285F4);
  
  static const Color profitColor = Color(0xFF0F9D58);
  static const Color profitLightColor = Color(0xFFE8F5E9);
  static const Color lossColor = Color(0xFFD93025);
  static const Color lossLightColor = Color(0xFFFFEBEE);
  
  static const Color cardColor = Colors.white;
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color surfaceColor = Colors.white;
  static const Color dividerColor = Color(0xFFE0E0E0);
  
  static const Color textPrimaryColor = Color(0xFF202124);
  static const Color textSecondaryColor = Color(0xFF5F6368);
  static const Color textHintColor = Color(0xFF9AA0A6);
  static const Color textDisabledColor = Color(0xFFBDC1C6);
  
  static const Color stockColor = Color(0xFF1A73E8);
  static const Color etfColor = Color(0xFF7B1FA2);
  static const Color cryptoColor = Color(0xFFFF6F00);
  static const Color bondColor = Color(0xFF0D7377);
  static const Color commodityColor = Color(0xFFD84315);
  
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      surface: surfaceColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textPrimaryColor,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: backgroundColor,
    cardTheme: CardThemeData(
      color: cardColor,
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: dividerColor.withOpacity(0.2), width: 1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: surfaceColor,
      foregroundColor: textPrimaryColor,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
        letterSpacing: -0.5,
      ),
      iconTheme: IconThemeData(color: textPrimaryColor),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceColor,
      selectedColor: primaryLightColor,
      disabledColor: backgroundColor,
      labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: dividerColor),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: dividerColor,
      thickness: 1,
      space: 1,
    ),
  );
  
  static TextStyle get headlineLarge => const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: textPrimaryColor,
    letterSpacing: -1,
    height: 1.2,
  );
  
  static TextStyle get headlineMedium => const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
    letterSpacing: -0.5,
    height: 1.3,
  );
  
  static TextStyle get headlineSmall => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
    letterSpacing: -0.5,
  );
  
  static TextStyle get titleLarge => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
    letterSpacing: -0.3,
  );
  
  static TextStyle get titleMedium => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
    letterSpacing: -0.2,
  );
  
  static TextStyle get titleSmall => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );
  
  static TextStyle get bodyLarge => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textPrimaryColor,
    height: 1.5,
  );
  
  static TextStyle get bodyMedium => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textSecondaryColor,
    height: 1.5,
  );
  
  static TextStyle get bodySmall => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textSecondaryColor,
    height: 1.4,
  );
  
  static TextStyle get labelLarge => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textSecondaryColor,
    letterSpacing: 0.1,
  );
  
  static TextStyle get labelMedium => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: textSecondaryColor,
    letterSpacing: 0.5,
  );
  
  static TextStyle get labelSmall => const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: textHintColor,
    letterSpacing: 0.5,
  );
  
  static Color getAssetTypeColor(String assetType) {
    switch (assetType.toLowerCase()) {
      case 'stock':
        return stockColor;
      case 'etf':
        return etfColor;
      case 'crypto':
      case 'cryptocurrency':
        return cryptoColor;
      case 'bond':
        return bondColor;
      case 'commodity':
        return commodityColor;
      default:
        return primaryColor;
    }
  }
  
  static BoxShadow get cardShadow => BoxShadow(
    color: Colors.black.withOpacity(0.06),
    blurRadius: 8,
    offset: const Offset(0, 2),
  );
  
  static BoxShadow get elevatedShadow => BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 16,
    offset: const Offset(0, 4),
  );
}
