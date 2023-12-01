// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:jobjolt/feature/auth/provider/auth_provider.dart';
import 'package:jobjolt/gen/assets.gen.dart';
import 'package:jobjolt/shared/route/app_router.dart';

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

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              const SizedBox(height: 125),
              SvgPicture.asset(
                Assets.images.logo.jobjolt,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn
                ),
                semanticsLabel: 'JobJolt Logo',
                width: MediaQuery.of(context).size.width / 2.5,
              ),
              const SizedBox(height: 64),
              TextFormField(
                controller: _controllerUsername,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "email".tr(),
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onEditingComplete: () => _focusNodePassword.requestFocus(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email.";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controllerPassword,
                focusNode: _focusNodePassword,
                obscureText: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "password".tr(),
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: _obscurePassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password.";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  FilledButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        ref
                            .read(authNotifierProvider.notifier)
                            .login(_controllerUsername.text, _controllerPassword.text);
                      }
                    },
                    child: Text("sign_in".tr()),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
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
    );
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
