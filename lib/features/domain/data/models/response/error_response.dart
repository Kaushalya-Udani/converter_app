import 'dart:convert';
import '../../entities/error_entity.dart';

class ErrorResponseModel extends ErrorResponseEntity {
  const ErrorResponseModel({
    required this.responseCode,
    required this.responseError,
  }) : super(responseCode: responseCode, responseError: responseError);

  @override
  final String responseCode;
  final String responseError;

  factory ErrorResponseModel.fromRawJson(String str) => ErrorResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => ErrorResponseModel(
        responseCode: json["response_code"],
        responseError: json["response_error"],
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_error": responseError,
      };
}
