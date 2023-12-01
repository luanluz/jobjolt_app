// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Project imports:
import 'package:jobjolt/start.dart';
import 'gen/assets.gen.dart';

Future<void> main() async {
  await dotenv.load(fileName: Assets.env.envDevelopment);

  await start();
}
