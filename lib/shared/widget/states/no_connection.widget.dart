import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobjolt/gen/assets.gen.dart';
import 'package:jobjolt/shared/widget/states/base_state.widget.dart';

class NoConnectionState extends StatelessWidget {
  final String text;

  const NoConnectionState(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return BaseStateWidget(
      image: SvgPicture.asset(
        Assets.images.states.noConnection,
        semanticsLabel: 'No Connection',
        height: MediaQuery.of(context).size.height / 2,
      ),
      text: text
    );
  }
}
