// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:jobjolt/feature/auth/provider/auth_provider.dart';
import 'package:jobjolt/shared/services/notification.service.dart';
import 'package:jobjolt/shared/util/validator.util.dart';
import 'package:jobjolt/shared/widget/button/jobjolt_filled_button.widget.dart';
import 'package:jobjolt/shared/widget/form/jobjolt_email_field.widget.dart';
import 'package:jobjolt/shared/widget/form/jobjolt_password_field.widget.dart';
import 'package:jobjolt/shared/widget/form/jobjolt_text_form_field.widget.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodePassword = FocusNode();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    ref.listenManual(authNotifierProvider, (previous, next) {
      next.whenOrNull(
          loggedIn: () => NotificationService.success('hello_back'.tr()),
          error: (error) => error.when(
              connectivity: NotificationService.error,
              unauthorized: NotificationService.error,
              errorWithMessage: NotificationService.error,
              error: NotificationService.error
          )
      );
    });
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      key: _formKey,
                      child: Column(
                        children: [
                          JobJoltTextFormField(
                            controller: _usernameController,
                            prefixIcon: const Icon(Icons.person_outline),
                            labelText: "username".tr(),
                            validator: ValidatorUtil.usernameValidate,
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
                                  onPressed: () async {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      await ref.read(authNotifierProvider.notifier)
                                          .signUp(
                                            _usernameController.text,
                                            _emailController.text,
                                            _passwordController.text
                                          );

                                      if (context.mounted) {
                                        context.pop();
                                      }
                                    }
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
