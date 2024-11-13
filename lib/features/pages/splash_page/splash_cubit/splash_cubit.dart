import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../utils/app_constants.dart';
import '../../../../utils/failures.dart';
import '../../../domain/usecases/splash_usecase.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final Splash splash;

  SplashCubit({required this.splash}) : super(SplashInitial());

  Future<dynamic> getData({String? type = "USD"}) async {
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
          AppConstants.currencyList = r.data;
          return SplashSuccessState();
        },
      ),
    );
  }


}

