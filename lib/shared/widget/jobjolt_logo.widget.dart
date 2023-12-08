// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:jobjolt/gen/assets.gen.dart';

class JobJoltLogo extends StatelessWidget {
  final double? width;
  final double? height;

  const JobJoltLogo({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.images.logo.jobjolt,
      colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.primary,
          BlendMode.srcIn
      ),
      semanticsLabel: 'JobJolt Logo',
      width: width ?? MediaQuery.of(context).size.width / 2.5,
      height: height,
    );
  }
}
