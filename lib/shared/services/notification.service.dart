// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:m_toast/m_toast.dart';

// Project imports:
import 'package:jobjolt/shared/route/app_router.dart';

final _context = globalNavigatorKey.currentContext!;
final _toast = ShowMToast(_context);
const _alignment = Alignment.bottomCenter;

class NotificationService {
  static void success(String? message) {
    message ??= 'Sucesso';

    _toast.successToast(
      message: message,
      alignment: _alignment,
      duration: 1500,
    );
  }

  static void error(String? message) {
    message ??= 'Erro';

    _toast.errorToast(
      message: message,
      alignment: _alignment,
    );
  }

  static void info(String? message) {
    message ??= 'Info';

    _toast.successToast(
      icon: Icons.info,
      iconColor: Colors.blue[800],
      message: message,
      alignment: _alignment,
      backgroundColor: Colors.blue[50],
    );
  }

  static void warning(String? message) {
    message ??= 'Aviso';

    _toast.successToast(
      icon: Icons.warning,
      iconColor: Colors.yellow[800],
      message: message,
      alignment: _alignment,
      backgroundColor: Colors.yellow[50],
    );
  }
}
