import 'package:equatable/equatable.dart';

import '../features/domain/data/entities/error_entity.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => props;
}

// General failures
class ServerFailure extends Failure {
  final ErrorResponseEntity errorResponse;

  const ServerFailure({required this.errorResponse});
}

class APIFailure extends Failure {
  final ErrorResponseEntity errorResponse;

  const APIFailure(this.errorResponse);
}

class DioExceptionFailure extends Failure {
  final ErrorResponseEntity errorResponse;

  const DioExceptionFailure(this.errorResponse);
}

class ConnectionFailure extends Failure {}
