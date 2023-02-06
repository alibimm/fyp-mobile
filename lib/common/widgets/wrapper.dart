import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/feature/home/view/home_page.dart';
import 'package:fyp_mobile/feature/login/model/main_user.dart';
import 'package:fyp_mobile/feature/login/service/bloc/login_bloc.dart';
import 'package:fyp_mobile/feature/login/view/login_page.dart';
import 'package:fyp_mobile/service/lifecycle/lifecycle_watcher.dart';
import 'package:fyp_mobile/service/lifecycle/lifecycle_watcher_provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return LifecycleWatcherProvider(
      child: LifecycleWatcher(
        child: BlocBuilder<LoginBloc, MainUser?>(
          builder: (context, user) {
            if (user == null) return LoginPage();
            return const HomePage();
          },
        ),
      ),
    );
  }
}
