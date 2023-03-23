import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/common/utils/extensions.dart';
import 'package:fyp_mobile/common/widgets/animated_loader.dart';
import 'package:fyp_mobile/common/widgets/bottom_navbar.dart';
import 'package:fyp_mobile/constants/keys.dart';
import 'package:fyp_mobile/service/loader_indicator.dart';
import 'package:fyp_mobile/service/message_dialog.dart';
import 'package:fyp_mobile/service/navigation/custom_router.dart';

class NavWrapper extends StatelessWidget {
  const NavWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(),
      body: Stack(
        children: [
          SizedBox(
            width: context.width,
            height: context.height,
            child: Navigator(
              key: Keys.customNavigationKey,
              initialRoute: 'home',
              onGenerateRoute: CustomRouter.generateRoute,
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
              if (message.title == null) return const SizedBox.shrink();
              return Positioned(top: 0, child: Text(message.title ?? ''));
            },
          ),
        ],
      ),
    );
  }
}