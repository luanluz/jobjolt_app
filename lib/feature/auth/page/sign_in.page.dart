// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:jobjolt/feature/auth/provider/auth_provider.dart';
import 'package:jobjolt/shared/route/app_router.dart';
import 'package:jobjolt/shared/services/notification.service.dart';
import 'package:jobjolt/shared/widget/button/jobjolt_filled_button.widget.dart';
import 'package:jobjolt/shared/widget/form/jobjolt_email_field.widget.dart';
import 'package:jobjolt/shared/widget/form/jobjolt_password_field.widget.dart';
import 'package:jobjolt/shared/widget/jobjolt_logo.widget.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const JobJoltLogo(),
                    const SizedBox(height: 64),
                    JobJoltEmailField(
                      controller: _controllerUsername,
                      onEditingComplete: _focusNodePassword.requestFocus,
                    ),
                    const SizedBox(height: 16),
                    JobJoltPasswordField(
                      controller: _controllerPassword,
                      focusNode: _focusNodePassword,
                    ),
                    const SizedBox(height: 32),
                    Column(
                      children: [
                        JobJoltFilledButton(
                          text: "sign_in".tr(),
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              await ref
                                  .read(authNotifierProvider.notifier)
                                  .login(_controllerUsername.text, _controllerPassword.text);
                            }
                          },
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("dont_have_an_account".tr()),
                            TextButton(
                              onPressed: () {
                                _formKey.currentState?.reset();

                                ref.read(routerProvider).push(SignUpRoute.path);
                              },
                              child: Text("sign_up".tr()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
