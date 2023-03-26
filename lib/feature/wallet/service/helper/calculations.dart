import 'package:fyp_mobile/feature/wallet/model/account.dart';

class CalculateAccounts {
  static double calculateTotalBalance(List<Account> accounts) {
    double balance = 0.0;
    for (final account in accounts) {
      balance += account.balance;
    }
    return balance;
  }
}