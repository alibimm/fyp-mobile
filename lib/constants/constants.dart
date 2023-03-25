import 'package:get_it/get_it.dart';

// GetIt
final GetIt getIt = GetIt.instance;

// Secure Storage
const String mainUserKey = 'MainUser';
const String mainUserIdKey = 'MainUserId';
const String accessTokenKey = 'AccessToken';
// TODO: add hiveboxes
// Cache
const String defaultBox = 'DefaultBox';
const String transactionsBox = 'TransactionsBox';
const Set<String> hiveBoxes = {defaultBox, transactionsBox};

// API
const String baseUrl = "http://localhost:3030";
const String authenticationEndpoint = "$baseUrl/authentication";
const String usersEndpoint = "$baseUrl/users";
const String accountEndpoint = "$baseUrl/account";
const String transactionEndpoint = "$baseUrl/transaction";

// Formatting
const int doublePresicion = 2;
