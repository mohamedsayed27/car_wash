part of 'orders_cubit.dart';


sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class ChangeCarType extends OrdersState {}
final class ChangeSelectedTimeSchedule extends OrdersState {}
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

final class GetTimeScheduleLoadingStates extends OrdersState {}
final class GetTimeScheduleSuccessStates extends OrdersState {

}
final class GetTimeScheduleErrorStates extends OrdersState {
  final String? error;

  GetTimeScheduleErrorStates({this.error,});
}

final class MakeOrderLoadingState extends OrdersState {}
final class MakeOrderSuccessState extends OrdersState {
  final BaseResponseModel baseResponseModel;

  MakeOrderSuccessState({required this.baseResponseModel});
}
final class MakeOrderErrorState extends OrdersState {
  final String? error;

  MakeOrderErrorState({this.error,});
}



final class GetAllOrderLoadingStates extends OrdersState {}

final class GetAllOrderSuccessStates extends OrdersState {}

final class GetAllOrderErrorStates extends OrdersState {
  final String error;

  GetAllOrderErrorStates({required this.error});
}

final class RateOrderLoadingStates extends OrdersState {}

final class RateOrderSuccessStates extends OrdersState {}

final class RateOrderErrorStates extends OrdersState {
  final String error;

  RateOrderErrorStates({required this.error});
}



final class GetSingleOrderLoadingStates extends OrdersState {}

final class GetSingleOrderSuccessStates extends OrdersState {
  final SingleOrderModel? singleOrderModel;

  GetSingleOrderSuccessStates({
    required this.singleOrderModel,
  });
}

final class GetSingleOrderErrorStates extends OrdersState {
  final String error;

  GetSingleOrderErrorStates({required this.error});
}


final class DeleteOrderLoadingStates extends OrdersState {}

final class DeleteOrderSuccessStates extends OrdersState {
  final BaseResponseModel? baseResponseModel;

  DeleteOrderSuccessStates({
    required this.baseResponseModel,
  });
}

final class DeleteOrderErrorStates extends OrdersState {
  final String error;

  DeleteOrderErrorStates({required this.error});
}