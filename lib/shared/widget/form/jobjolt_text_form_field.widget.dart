// Flutter imports:
import 'package:flutter/material.dart';

class JobJoltTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool obscureText;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;

  const JobJoltTextFormField({
    super.key,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.keyboardType,
    this.onEditingComplete,
    this.validator,
    this.focusNode,
    this.obscureText = false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusNode,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      onEditingComplete: onEditingComplete,
      validator: validator,
    );
  }
}
