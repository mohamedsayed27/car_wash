part of 'orders_cubit.dart';


sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class ChangeCarType extends OrdersState {}
final class GetCarTypesLoadingStates extends OrdersState {}
final class GetCarTypesSuccessStates extends OrdersState {

}
final class GetCarTypesErrorStates extends OrdersState {
  final String? error;

  GetCarTypesErrorStates({this.error,});
}

final class GetServicesLoadingStates extends OrdersState {}
final class GetServicesSuccessStates extends OrdersState {

}
final class GetServicesErrorStates extends OrdersState {
  final String? error;

  GetServicesErrorStates({this.error,});
}
