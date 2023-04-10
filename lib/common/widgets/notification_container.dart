import 'package:flutter/material.dart';
import 'package:fyp_mobile/common/utils/app_color.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';

class NotificationContainer extends StatelessWidget {
  final String message;
  const NotificationContainer({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      padding: const EdgeInsets.all(16.0),
      width: context.width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: AppColor.backgroundElementGradient),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }
}
