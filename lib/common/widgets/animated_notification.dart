import 'package:flutter/material.dart';
import 'package:fyp_mobile/common/widgets/notification_container.dart';

class NotificationAnimatedContainer extends StatefulWidget {
  final String message;

  const NotificationAnimatedContainer({super.key, required this.message});

  @override
  NotificationAnimatedContainerState createState() => NotificationAnimatedContainerState();
}

class NotificationAnimatedContainerState extends State<NotificationAnimatedContainer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: NotificationContainer(message: widget.message),
    );
  }
}
