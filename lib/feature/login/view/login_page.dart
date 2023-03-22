import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/feature/login/service/cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).login(emailController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              TextButton(
                onPressed: () => login(context),
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
