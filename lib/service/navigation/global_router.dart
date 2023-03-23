import 'package:flutter/cupertino.dart';
import 'package:fyp_mobile/common/widgets/nav_wrapper.dart';
import 'package:fyp_mobile/common/widgets/not_found_page.dart';
import 'package:fyp_mobile/common/widgets/auth_wrapper.dart';

class GlobalRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'login':
        return CupertinoPageRoute(builder: (BuildContext context) => const AuthWrapper());
      case 'nav':
        return CupertinoPageRoute(builder: (BuildContext context) => const NavWrapper());
      default:
        return CupertinoPageRoute(
          builder: (BuildContext context) => const NotFoundPage(),
        );
    }
  }
}
