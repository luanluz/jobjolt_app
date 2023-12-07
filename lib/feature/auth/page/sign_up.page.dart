// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:jobjolt/feature/auth/provider/auth_provider.dart';
import 'package:jobjolt/shared/widget/button/jobjolt_filled_button.widget.dart';
import 'package:jobjolt/shared/widget/form/jobjolt_email_field.widget.dart';
import 'package:jobjolt/shared/widget/form/jobjolt_password_field.widget.dart';
import 'package:jobjolt/shared/widget/form/jobjolt_text_form_field.widget.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({super.key});
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Column(children: <Widget>[
                  Text(
                    "sign_up".tr(),
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 64),
                  Form(
                    child: Column(
                      children: [
                        JobJoltTextFormField(
                          controller: _nameController,
                          prefixIcon: const Icon(Icons.person_outline),
                          labelText: "name".tr(),
                        ),
                        const SizedBox(height: 16),
                        JobJoltEmailField(
                          controller: _emailController,
                        ),
                        const SizedBox(height: 16),
                        JobJoltPasswordField(
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 32),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              JobJoltFilledButton(
                                text: "sign_up".tr(),
                                onPressed: () {
                                  ref.read(authNotifierProvider.notifier).signUp(_nameController.text,
                                      _emailController.text, _passwordController.text);
                                },
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("already_have_an_account".tr()),
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: Text("sign_in".tr()),
                                  ),
                                ],
                              ),
                            ]
                        ),
                      ],
                    ),
                  )
                ]
              )
            ),
          )
        ],
      )
    );
  }
}
