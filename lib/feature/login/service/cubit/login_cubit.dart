import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/service/loader_indicator.dart';
import 'package:fyp_mobile/service/message_dialog.dart';
import 'package:fyp_mobile/feature/login/model/main_user.dart';
import '../repositories/login_repository.dart';

abstract class LoginBloc extends Cubit<MainUser?> {
  LoginBloc(MainUser? state) : super(state);
  Future<bool> login(String email, String password);
  Future<bool> register(String email, String password);
  Future logout();
  Future initUser();
}

class LoginBlocImpl extends LoginBloc {
  final LoginRepository repository;
  final LoaderIndicator loaderIndicator;
  final MessageDialog messageDialog;

  LoginBlocImpl({
    required this.repository,
    required this.loaderIndicator,
    required this.messageDialog,
  }) : super(null);

  @override
  Future<bool> login(String email, String password) async {
    loaderIndicator.run();
    final data = await repository.login(email, password);
    if (data.object != null) {
      emit(data.object as MainUser);
    } else {
      messageDialog.show(message: data.errorMessage ?? 'Cannot login');
    }
    loaderIndicator.stop();
    return data.object != null;
  }

  @override
  Future<bool> register(String email, String password) async {
    loaderIndicator.run();
    final data = await repository.register(email, password);
    if (data.object != null) {
      messageDialog.show(message: 'Registration successful');
    } else {
      messageDialog.show(message: data.errorMessage ?? 'Cannot register');

    }
    loaderIndicator.stop();
    return data.object != null;
  }

  @override
  Future logout() async {
    await repository.logout();
    emit(null);
  }

  @override
  Future initUser() async {
    final data = await repository.getUser();
    if (data.object != null) {
      emit(data.object as MainUser);
      return;
    }
    emit(null);
  }
}
