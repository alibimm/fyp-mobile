import 'package:flutter/cupertino.dart';
import 'package:fyp_mobile/common/widgets/not_found_page.dart';
import 'package:fyp_mobile/feature/main_page.dart';
import 'package:fyp_mobile/feature/profile/views/profile_page.dart';
import 'package:fyp_mobile/feature/stats/views/stats_page.dart';
import 'package:fyp_mobile/feature/transaction/view/create_transaction_page.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return CupertinoPageRoute(builder: (BuildContext context) => const MainPage());
      case 'statistics':
        return CupertinoPageRoute(builder: (BuildContext context) => const StatisticsPage());
      case 'profile':
        return CupertinoPageRoute(builder: (BuildContext context) => const ProfilePage());
      case 'create_transaction':
        return CupertinoPageRoute(builder: (BuildContext context) => const CreateTransactionPage());
      default:
        return CupertinoPageRoute(builder: (BuildContext context) => const NotFoundPage());
    }
  }
}
