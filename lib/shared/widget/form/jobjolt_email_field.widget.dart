import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jobjolt/shared/widget/form/jobjolt_text_form_field.widget.dart';

class JobJoltEmailField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;

  const JobJoltEmailField({
    super.key,
    this.controller,
    this.onEditingComplete,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return JobJoltTextFormField(
      controller: controller,
      prefixIcon: const Icon(Icons.email_outlined),
      labelText: "email".tr(),
      keyboardType: TextInputType.name,
      onEditingComplete: onEditingComplete,
      validator: validator ?? (String? value) {
        if (value == null || value.isEmpty) {
          return "Please enter email.";
        }

        return null;
      },
    );
  }
}
