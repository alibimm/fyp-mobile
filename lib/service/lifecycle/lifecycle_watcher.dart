import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/feature/login/service/cubit/login_cubit.dart';

class LifecycleWatcher extends StatefulWidget {
  final Widget child;
  const LifecycleWatcher({super.key, required this.child});

  @override
  State<LifecycleWatcher> createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginBloc>(context).initUser();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
