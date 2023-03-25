import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/feature/login/model/main_user.dart';
import 'package:fyp_mobile/feature/login/service/cubit/login_cubit.dart';

class ProfilePageView extends StatelessWidget {
  final MainUser mainUser;
  const ProfilePageView({super.key, required this.mainUser});

  @override
  Widget build(BuildContext context) {
    final email = mainUser.user?.email ?? 'no user';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(email),
        TextButton(
          onPressed: () => BlocProvider.of<LoginBloc>(context).logout(),
          child: const Text('Logout'),
        )
      ],
    );
  }
}
