// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:jobjolt/shared/util/validator.util.dart';
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
      validator: validator ?? ValidatorUtil.emailValidate,
    );
  }
}
