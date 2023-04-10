import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';
import 'package:fyp_mobile/common/widgets/animated_loader.dart';
import 'package:fyp_mobile/common/widgets/animated_notification.dart';
import 'package:fyp_mobile/common/widgets/nav_wrapper.dart';
import 'package:fyp_mobile/feature/login/model/main_user.dart';
import 'package:fyp_mobile/feature/login/service/cubit/login_cubit.dart';
import 'package:fyp_mobile/feature/login/view/login_page.dart';
import 'package:fyp_mobile/service/lifecycle/lifecycle_watcher.dart';
import 'package:fyp_mobile/service/lifecycle/lifecycle_watcher_provider.dart';
import 'package:fyp_mobile/service/loader_indicator.dart';
import 'package:fyp_mobile/service/message_dialog.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return LifecycleWatcherProvider(
      child: LifecycleWatcher(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                width: context.width,
                height: context.height,
                child: BlocBuilder<LoginBloc, MainUser?>(
                  builder: (context, user) {
                    if (user == null) return const LoginPage();
                    return const NavWrapper();
                  },
                ),
              ),
              BlocBuilder<LoaderIndicator, bool>(
                builder: (context, state) {
                  if (!state) return const SizedBox.shrink();
                  return const Positioned(top: 0, child: AnimatedLoader());
                },
              ),
              BlocBuilder<MessageDialog, Message>(
                builder: (context, message) {
                  if (message.subtitle == null) return const SizedBox.shrink();
                  return SafeArea(child: NotificationAnimatedContainer(message: message.subtitle ?? 'Message'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
