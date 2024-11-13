
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../utils/app_constants.dart';
import '../../../../utils/failures.dart';
import '../../../domain/data/models/response/currencies_response.dart';
import '../../../domain/usecases/splash_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final Splash splash;

  HomeCubit({required this.splash}) : super(HomeInitial());

  Future<dynamic> getCurrencyConvertData({String? type = "USD"}) async {
    emit(ApiLoadingState());
    final result = await splash({"apikey": AppConstants.apiKeyValue, "base_currency": type});
    emit(
      result.fold(
            (l) {
          if (l is DioExceptionFailure) {
            return DioExceptionFailureState();
          } else if (l is ServerFailure) {
            return ServerFailureState();
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState();
          } else {
            return ApiFailureState();
          }
        },
            (r) {
          return HomeSuccessState(currenciesResponse: r);
        },
      ),
    );
  }

}
