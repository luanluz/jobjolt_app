// Dart imports:
import 'dart:async';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:jobjolt/app/page/app.dart';
import 'package:jobjolt/shared/util/logger.util.dart';
import 'package:jobjolt/shared/util/platform_type.util.dart';

Future<void> start() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final platformType = detectPlatformType();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en')],
    path: 'assets/lang',
    fallbackLocale: const Locale('en'),
    child: ProviderScope(overrides: [
      platformTypeProvider.overrideWithValue(platformType),
    ], observers: [
      Logger()
    ], child: const App()),
  ));
}
