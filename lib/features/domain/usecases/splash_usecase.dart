import 'package:curancy_converter_app/features/domain/usecases/usecase.dart';
import '../../../utils/failures.dart';
import '../data/models/response/currencies_response.dart';
import '../repository/repository.dart';
import 'package:dartz/dartz.dart';


class Splash extends UseCase<CurrenciesResponse, Map<String, dynamic>> {
  final Repository repository;

  Splash({required this.repository});

  @override
  Future<Either<Failure, CurrenciesResponse>> call(Map<String, dynamic> params) async {
    return await repository.splash(params);
  }
}
