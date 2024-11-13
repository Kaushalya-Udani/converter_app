part of 'home_cubit.dart';


@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ApiLoadingState extends HomeState {}

class ApiFailureState extends HomeState {}

class DioExceptionFailureState extends HomeState {}

class ServerFailureState extends HomeState {}

class ConnectionFailureState extends HomeState {}

class HomeSuccessState extends HomeState {
  final CurrenciesResponse? currenciesResponse;

  HomeSuccessState({required this.currenciesResponse});
}