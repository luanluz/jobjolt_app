// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:zod_validation/zod_validation.dart';

// Project imports:
import 'package:jobjolt/shared/widget/form/jobjolt_text_form_field.widget.dart';

class JobJoltPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;

  const JobJoltPasswordField({
    super.key,
    this.controller,
    this.onEditingComplete,
    this.validator,
    this.focusNode,
    this.obscureText = false
  });

  @override
  State<JobJoltPasswordField> createState() => _JobJoltPasswordFieldState();
}

class _JobJoltPasswordFieldState extends State<JobJoltPasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return JobJoltTextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: _obscurePassword,
      prefixIcon: const Icon(Icons.password_outlined),
      suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
          icon: _obscurePassword
              ? const Icon(Icons.visibility_outlined)
              : const Icon(Icons.visibility_off_outlined)
      ),
      labelText: "password".tr(),
      keyboardType: TextInputType.visiblePassword,
      validator: widget.validator ?? Zod().required().password().build,
    );
  }
}

