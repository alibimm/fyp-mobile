import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/common/utils/app_color.dart';
import 'package:fyp_mobile/feature/login/service/cubit/login_cubit.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key, this.onGoToLogin});
  final Function? onGoToLogin;

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _passwordObscure = true;
  bool _confirmPasswordObscure = true;
  // String _confirmPassword = '';

  void register(BuildContext context) async {
    final result = await BlocProvider.of<LoginBloc>(context).register(_email, _password);
    if (mounted && result) {
      if (widget.onGoToLogin != null) widget.onGoToLogin!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  _email = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _passwordObscure = !_passwordObscure;
                      });
                    },
                    child: Icon(
                      _passwordObscure ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                      color: AppColor.darkPrimaryColor,
                    ),
                  ),
                ),
                obscureText: _passwordObscure,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  _password = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _confirmPasswordObscure = !_confirmPasswordObscure;
                      });
                    },
                    child: Icon(
                      _confirmPasswordObscure ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                      color: AppColor.darkPrimaryColor,
                    ),
                  ),
                ),
                obscureText: _confirmPasswordObscure,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please confirm your password';
                  } else if (value != _password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColor.darkPrimaryColor),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState!.save();
                    register(context);
                  }
                },
                child: const Text('Register'),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  if (widget.onGoToLogin != null) widget.onGoToLogin!();
                  // Navigator.pop(context);
                },
                child: const Text(
                  'Already have an account? Sign in here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.darkPrimaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
