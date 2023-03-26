import 'package:fyp_mobile/feature/transaction/model/transaction.dart';

class CalculateTransactions {
  static double currentMonthExpenses(List<Transaction> transactions) {
    double expenses = 0.0;

    for (final transaction in transactions) {
      if (transaction.type != TransactionType.expense) continue;
      if (!isThisMonth(transaction.date)) continue;
      expenses += transaction.amount;
    }

    return expenses;
  }

  static double currentMonthIncome(List<Transaction> transactions) {
    double income = 0.0;

    for (final transaction in transactions) {
      if (transaction.type != TransactionType.income) continue;
      if (!isThisMonth(transaction.date)) continue;
      income += transaction.amount;
    }

    return income;
  }

  static bool isThisMonth(DateTime? date) {
    return date?.month == DateTime.now().month;
  }
}
