import '../providers/transaction_api_provider.dart';

class TransactionApiProviderInject {
  static TransactionApiProvider? _transactionApiProvider;

  TransactionApiProviderInject._();

  static TransactionApiProvider? transactionApiProvider() {
    _transactionApiProvider ??= TransactionApiProviderImpl();
    return _transactionApiProvider;
  }
}
