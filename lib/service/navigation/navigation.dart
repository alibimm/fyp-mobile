
import 'package:flutter/material.dart';
import 'package:fyp_mobile/constants/keys.dart';
import 'package:fyp_mobile/service/navigation/base_navigation.dart';

class NavigationService extends BaseNavigation {
  NavigationService() : super('dashboard');

  @override
  void navigateTo(String? page, {dynamic arguments, bool forMenu = false}) {
    if (page?.isEmpty ?? true) return;
    Keys.customNavigationKey.currentState!.popUntil((route) {
      if (route.settings.name != page ||
          route.settings.arguments != arguments) {
        switch (page) {
          case 'login':
          case 'dashboard':
            Keys.customNavigationKey.currentState!.pushNamedAndRemoveUntil(
                page!, (route) => false,
                arguments: arguments);
            break;
          default:
            forMenu
                ? Keys.customNavigationKey.currentState!
                    .pushNamedAndRemoveUntil(page!, (route) => route.isFirst,
                        arguments: arguments)
                : Keys.customNavigationKey.currentState!
                    .pushNamed(page!, arguments: arguments);
        }
        emit(page);
      }
      return true;
    });
  }

  @override
  bool pop() {
    if (Keys.customNavigationKey.currentState!.canPop()) {
      Keys.customNavigationKey.currentState!.pop();
      return true;
    }
    return false;
  }

  @override
  void popEmit(Route<dynamic>? route, int index) {
    if (route?.settings.name != null ||
        route!.settings.name != null && route.settings.name!.isNotEmpty) {
      emit(route!.settings.name);
    }
  }
}
