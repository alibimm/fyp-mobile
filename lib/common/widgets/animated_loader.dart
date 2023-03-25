import 'package:fyp_mobile/common/utils/extensions.dart';
import 'package:flutter/material.dart';

class AnimatedLoader extends StatelessWidget {
  const AnimatedLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: const LinearProgressIndicator(
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation(Colors.green), // TODO: change the color
        value: null,
      ),
    );
  }
}
