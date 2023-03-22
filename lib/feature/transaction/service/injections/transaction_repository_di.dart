import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/service/network_info.dart';

import '../repositories/transaction_repository.dart';
import 'transaction_api_provider_di.dart';
import 'transaction_db_provider_di.dart';

class TransactionRepositoryInject {
  static TransactionRepository? _transactionRepository;

  TransactionRepositoryInject._();

  static TransactionRepository? transactionRepository() {
    _transactionRepository ??= TransactionRepositoryImpl(
      apiProvider: TransactionApiProviderInject.transactionApiProvider()!,
      dBProvider: TransactionDBProviderInject.transactionDBProvider()!,
      networkInfo: getIt<NetworkInfo>(),
    );
    return _transactionRepository;
  }
}
