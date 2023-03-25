import 'package:flutter/material.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';
import 'package:fyp_mobile/common/utils/style.dart';

class GreetingsWidget extends StatelessWidget {
  const GreetingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Greetings,',
          style: AppStyles.backgroundColorTextStyle.copyWith(fontWeight: FontWeight.w500),
        ),
        6.0.vSpace,
        Text(
          'Bob',
          style: AppStyles.backgroundColorTextStyle.copyWith(fontSize: 20),
        )
      ],
    );
  }
}
