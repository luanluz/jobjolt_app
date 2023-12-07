import 'package:flutter/material.dart';

class JobJoltFilledButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const JobJoltFilledButton({
    super.key,
    this.onPressed,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
