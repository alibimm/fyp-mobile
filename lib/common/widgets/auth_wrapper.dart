import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/common/widgets/nav_wrapper.dart';
import 'package:fyp_mobile/feature/login/model/main_user.dart';
import 'package:fyp_mobile/feature/login/service/cubit/login_cubit.dart';
import 'package:fyp_mobile/feature/login/view/login_page.dart';
import 'package:fyp_mobile/service/lifecycle/lifecycle_watcher.dart';
import 'package:fyp_mobile/service/lifecycle/lifecycle_watcher_provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return LifecycleWatcherProvider(
      child: LifecycleWatcher(
        child: BlocBuilder<LoginBloc, MainUser?>(
          builder: (context, user) {
            if (user == null) return LoginPage();
            return const NavWrapper();
          },
        ),
      ),
    );
  }
}
