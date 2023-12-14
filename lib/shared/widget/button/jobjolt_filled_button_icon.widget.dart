// Flutter imports:
import 'package:flutter/material.dart';

class JobJoltFilledButtonTonalIcon extends StatelessWidget {
  final String text;
  final Icon icon;
  final void Function()? onPressed;

  const JobJoltFilledButtonTonalIcon({
    super.key,
    this.onPressed,
    required this.text,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      icon: icon,
      label: Text(text),
    );
  }
}
