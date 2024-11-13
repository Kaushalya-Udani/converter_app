import 'package:dartz/dartz.dart';

import '../../../core/network_info.dart';
import '../../../utils/exception.dart';
import '../../../utils/failures.dart';
import '../data/datasources/remote_datasource.dart';
import '../data/entities/error_entity.dart';
import '../data/models/response/currencies_response.dart';

abstract class Repository{
  Future<Either<Failure,CurrenciesResponse>> splash(Map<String, dynamic> data);
}

class RepositoryImpl extends Repository {
  final RemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  RepositoryImpl({required this.remoteDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, CurrenciesResponse>> splash(Map<String, dynamic> data) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.splashRequest(data);
        return Right(response);
      } on DioExceptionError catch (e) {
        return Left(DioExceptionFailure(e.errorResponse!));
      } on Exception catch (e) {
        return Left(
          ServerFailure(
            errorResponse: ErrorResponseEntity(
              responseCode: "",
              responseError: e.toString(),
            ),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}