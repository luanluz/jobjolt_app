// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'package:jobjolt/gen/assets.gen.dart';
import 'package:jobjolt/start.dart';

Future<void> main() async {
  await dotenv.load(fileName: Assets.env.envStaging);

  await start();
}
