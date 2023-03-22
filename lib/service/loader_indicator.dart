import 'package:flutter_bloc/flutter_bloc.dart';

class LoaderIndicator extends Cubit<bool> {
  LoaderIndicator() : super(false);

  void run() => emit(true);
  void stop() => emit(false);
}