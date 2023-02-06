import 'package:equatable/equatable.dart';

class ApiResponse extends Equatable {
  final Object? object;
  final String? errorMessage;

  const ApiResponse({this.object, this.errorMessage});

  factory ApiResponse.success(Object? object) {
    return ApiResponse(
      object: object,
      errorMessage: null,
    );
  }

  factory ApiResponse.withError(String? error) {
    return ApiResponse(
      object: null,
      errorMessage: error,
    );
  }

  @override
  List<Object?> get props => [object, errorMessage];
}
