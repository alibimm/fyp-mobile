import 'package:get_it/get_it.dart';

// GetIt
final GetIt getIt = GetIt.instance;
// TODO: add hiveboxes
final Set<String> hiveBoxes = {};

// API
const String baseUrl = "http://localhost:3030";
const String authenticationEndpoint = "$baseUrl/authentication";
const String usersEndpoint = "$baseUrl/users";
const String accountEndpoint = "$baseUrl/account";
const String transactionEndpoint = "$baseUrl/transaction";
