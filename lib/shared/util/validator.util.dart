// Package imports:
import 'package:zod_validation/zod_validation.dart';

class ValidatorUtil {
  static String? emailValidate(String? email) =>
      Zod().required().email().build(email);

  static String? passwordValidate(String? email) =>
      Zod().required().password().build(email);

  static String? usernameValidate(String? username) =>
      Zod().min(2).max(20)
        .custom((v) => RegExp(r'^[a-zA-Z][a-zA-Z0-9_]{0,19}$').hasMatch(v))
        .build(username);
}
