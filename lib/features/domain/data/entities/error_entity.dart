import 'package:equatable/equatable.dart';

class ErrorResponseEntity extends Equatable {
  const ErrorResponseEntity({
    required this.responseCode,
    required this.responseError,
  });

  final String responseCode;
  final String responseError;

  @override
  List<Object> get props => [responseError, responseCode];
}
