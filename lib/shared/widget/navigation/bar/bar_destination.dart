// Flutter imports:
import 'package:flutter/material.dart';

class BarDestination {
  final String route;
  final String label;
  final Widget icon;
  final Widget? selectedIcon;

  BarDestination({
    required this.route,
    required this.label,
    required this.icon,
    this.selectedIcon
  });
}
