
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseNavigation extends Cubit<String?> {
  BaseNavigation(String? initialState) : super(initialState);

  void navigateTo(String? page, {dynamic arguments, bool forMenu = false});

  bool pop();

  void popEmit(Route<dynamic>? route, int index);
}
