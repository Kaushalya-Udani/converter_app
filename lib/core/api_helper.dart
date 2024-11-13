import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../features/domain/data/entities/error_entity.dart';
import '../utils/exception.dart';
import 'network_config.dart';

class APIHelper {
  late Dio dio;

  APIHelper({required this.dio}) {
    _initAPIClient();
  }

  void _initAPIClient() {
    final logInterceptor = LogInterceptor(
      requestBody: false,
      responseBody: false,
      requestHeader: false,
      responseHeader: false,
      error: false,

    );

    BaseOptions options = BaseOptions(
      baseUrl: NetworkConfig.getNetworkConfig(),
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      contentType: 'application/json',
    );

    dio
      ..options = options
      ..interceptors.add(logInterceptor);

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient dioClient = HttpClient(
          context: SecurityContext(
            withTrustedRoots: false,
          ),
        );
        dioClient.badCertificateCallback = (cert, host, port) => true;
        return dioClient;
      },
      validateCertificate: (cert, host, port) {
        return true;
      },
    );
  }

  Future<dynamic> post(T) async {}

  Future<dynamic> get(String tag, {Map<String, dynamic>? param}) async {
    try {
      final response = await dio.get(
        NetworkConfig.getNetworkConfig() + tag,
        queryParameters: param,
      );
      return response.data;
    } on DioException catch (error) {
      throw DioExceptionError(
        errorResponse: ErrorResponseEntity(
          responseCode: error.response!.statusCode.toString(),
          responseError: error.message??"",
        ),
      );
    }
  }
}

