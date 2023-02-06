import 'package:flutter/cupertino.dart';
import 'package:fyp_mobile/common/widgets/not_found_page.dart';
import 'package:fyp_mobile/common/widgets/wrapper.dart';
import 'package:fyp_mobile/feature/home/view/home_page.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'splash':
        return CupertinoPageRoute(
            builder: (BuildContext context) => const Wrapper());
      case 'home':
        return CupertinoPageRoute(
          builder: (BuildContext context) => const HomePage(),
        );
      default:
        return CupertinoPageRoute(
          builder: (BuildContext context) => const NotFoundPage(),
        );
    }
  }
}
