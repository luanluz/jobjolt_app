// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zod_validation/zod_validation.dart';

// Project imports:
import 'package:jobjolt/gen/assets.gen.dart';
import 'package:jobjolt/start.dart';

Future<void> main() async {
  await dotenv.load(fileName: Assets.env.envStaging);
  Zod.zodLocaleInstance = Locale.en_US;

  await start();
}
