import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/feature/login/model/main_user.dart';
import 'package:fyp_mobile/feature/login/service/cubit/login_cubit.dart';
import 'package:fyp_mobile/feature/profile/views/profile_page_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, MainUser?>(
      builder: (context, user) {
        if (user == null) return const SizedBox.shrink();
        return ProfilePageView(mainUser: user);
      },
    );
  }
}
