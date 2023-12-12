// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:jobjolt/shared/constant/color_schemes.dart';

class AppThemeData {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    navigationBarTheme: NavigationBarThemeData(
      iconTheme: MaterialStateProperty.resolveWith((states) =>
        states.contains(MaterialState.selected)
          ? IconThemeData(color: lightColorScheme.onPrimary)
          : const IconThemeData()
      ),
      indicatorColor: lightColorScheme.primary
    )
  );

  static ThemeData dark = ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      navigationBarTheme: NavigationBarThemeData(
          iconTheme: MaterialStateProperty.resolveWith((states) =>
          states.contains(MaterialState.selected)
              ? IconThemeData(color: darkColorScheme.onPrimary)
              : const IconThemeData()
          ),
          indicatorColor: darkColorScheme.primary
      )
  );
}
