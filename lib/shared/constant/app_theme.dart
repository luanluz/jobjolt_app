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
          ? IconThemeData(color: lightColorScheme.primary)
          : IconThemeData(color: lightColorScheme.outline)
      ),
      labelTextStyle: MaterialStateProperty.resolveWith((state) =>
        state.contains(MaterialState.selected)
            ? TextStyle(color: lightColorScheme.primary, fontSize: 12.0, fontWeight: FontWeight.w500)
            : TextStyle(color: lightColorScheme.outline, fontSize: 12.0, fontWeight: FontWeight.w500)
      ),
      indicatorColor: Colors.transparent
    )
  );

  static ThemeData dark = ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      navigationBarTheme: NavigationBarThemeData(
          iconTheme: MaterialStateProperty.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? IconThemeData(color: darkColorScheme.primary)
                : IconThemeData(color: lightColorScheme.outline)
          ),
          labelTextStyle: MaterialStateProperty.resolveWith((state) =>
            state.contains(MaterialState.selected)
                ? TextStyle(color: lightColorScheme.primary, fontSize: 12.0, fontWeight: FontWeight.w500)
                : TextStyle(color: lightColorScheme.outline, fontSize: 12.0, fontWeight: FontWeight.w500)
          ),
          indicatorColor: Colors.transparent
      )
  );
}
