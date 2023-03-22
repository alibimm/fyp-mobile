import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@lazySingleton
class NetworkInfo extends Cubit<bool> {
  final InternetConnectionChecker connectionChecker;

  NetworkInfo({required this.connectionChecker}) : super(true) {
    connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        emit(true);
      } else {
        emit(false);
      }
    });
  }

  Future<bool> get isConnected => connectionChecker.hasConnection;
}
