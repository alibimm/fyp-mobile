import 'package:flutter/cupertino.dart';
import 'package:fyp_mobile/common/widgets/not_found_page.dart';
import 'package:fyp_mobile/feature/home/view/home_page.dart';
import 'package:fyp_mobile/feature/profile/views/profile_page.dart';
import 'package:fyp_mobile/feature/stats/views/stats_page.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return CupertinoPageRoute(builder: (BuildContext context) => const HomePage());
      case 'statistics':
        return CupertinoPageRoute(builder: (BuildContext context) => const StatisticsPage());
      case 'profile':
        return CupertinoPageRoute(builder: (BuildContext context) => const ProfilePage());
      default:
        return CupertinoPageRoute(builder: (BuildContext context) => const NotFoundPage());
    }
  }
}
