import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/domain/repository/repository.dart';
import '../../features/domain/usecases/splash_usecase.dart';
import '../features/domain/data/datasources/remote_datasource.dart';
import '../features/domain/data/datasources/shared_preference.dart';
import '../features/pages/home/home_cubit/home_cubit.dart';
import '../features/pages/splash_page/splash_cubit/splash_cubit.dart';
import 'api_helper.dart';
import 'network_info.dart';

final injection = GetIt.instance;

Future<dynamic> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  injection.registerLazySingleton(() => sharedPreferences);
  injection.registerSingleton(Dio());
  injection.registerLazySingleton<APIHelper>(() => APIHelper(dio: injection()));
  injection.registerLazySingleton(() => Connectivity());
  injection.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: injection()));


  injection.registerSingleton(AppSharedData(injection()));


  injection.registerLazySingleton<RemoteDatasource>(() => RemoteDatasourceImpl(apiHelper: injection()));


  injection.registerLazySingleton<Repository>(() => RepositoryImpl(remoteDatasource: injection(), networkInfo: injection()));


  injection.registerLazySingleton(() => Splash(repository: injection()));


  injection.registerFactory(() => SplashCubit(splash: injection()));
  injection.registerFactory(() => HomeCubit(splash: injection()));
}
