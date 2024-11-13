part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class ApiLoadingState extends SplashState {}

class ApiFailureState extends SplashState {}

class DioExceptionFailureState extends SplashState {}

class ServerFailureState extends SplashState {}

class ConnectionFailureState extends SplashState {}

class SplashInitial extends SplashState {}

class SplashSuccessState extends SplashState {}
