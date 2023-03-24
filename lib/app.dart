import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/constants/constants.dart';
import 'package:fyp_mobile/constants/keys.dart';
import 'package:fyp_mobile/feature/login/service/cubit/login_cubit.dart';
import 'package:fyp_mobile/feature/login/service/injections/login_repository_di.dart';
import 'package:fyp_mobile/service/loader_indicator.dart';
import 'package:fyp_mobile/service/message_dialog.dart';
import 'package:fyp_mobile/service/navigation/base_navigation.dart';
import 'package:fyp_mobile/service/navigation/navigation.dart';
import 'package:fyp_mobile/service/navigation/global_router.dart';
import 'package:fyp_mobile/service/network_info.dart';
import 'package:fyp_mobile/service/storage/cache_storage.dart';
import 'package:fyp_mobile/service/storage/secure_storage.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void dispose() {
    super.dispose();
    getIt<CacheStorage>().close();
    getIt<SecureStorage>().close();
    getIt.reset(dispose: true);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BaseNavigation>(create: (_) => NavigationService()),
        BlocProvider(create: (_) => getIt<LoaderIndicator>()),
        BlocProvider(create: (_) => getIt<NetworkInfo>()),
        BlocProvider(create: (_) => getIt<MessageDialog>()),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBlocImpl(
            repository: LoginRepositoryInject.loginRepository()!,
            loaderIndicator: getIt<LoaderIndicator>(),
            messageDialog: getIt<MessageDialog>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Inter'),
        home: WillPopScope(
          child: Navigator(
            key: Keys.globalNavigationKey,
            initialRoute: 'login',
            onGenerateRoute: GlobalRouter.generateRoute,
          ),
          onWillPop: () async {
            return !BlocProvider.of<BaseNavigation>(context).pop();
          },
        ),
      ),
    );
  }
}
