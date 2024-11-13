
import '../../../../core/api_helper.dart';
import '../models/response/currencies_response.dart';

abstract class RemoteDatasource {
  Future<CurrenciesResponse> splashRequest(Map<String, dynamic> data);
}

class RemoteDatasourceImpl extends RemoteDatasource {
  final APIHelper apiHelper;

  RemoteDatasourceImpl({required this.apiHelper});

  @override
  Future<CurrenciesResponse> splashRequest(Map<String, dynamic> data) async {
    try {
      final response = await apiHelper.get(
        "latest/",
        param: data,
      );
      return CurrenciesResponse.fromJson(response);
    } on Exception {
      rethrow;
    }
  }
}
