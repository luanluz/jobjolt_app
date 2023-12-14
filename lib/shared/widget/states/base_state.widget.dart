import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobjolt/gen/assets.gen.dart';

class BaseStateWidget extends StatelessWidget {
  final String text;
  final Widget image;

  const BaseStateWidget({
    super.key,
    required this.image,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            image,
            Text(
              text,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            )
          ],
        ),
      )
    );
  }
}
