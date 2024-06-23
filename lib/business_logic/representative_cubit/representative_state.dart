part of 'representative_cubit.dart';

sealed class RepresentativeState {}

final class RepresentativeInitial extends RepresentativeState {}

final class LoadingStates extends RepresentativeState {}

final class SuccessStates extends RepresentativeState {}

final class ErrorStates extends RepresentativeState {
  final String error;

  ErrorStates({required this.error});
}

final class GetSingleOrderLoadingStates extends RepresentativeState {}

final class GetSingleOrderSuccessStates extends RepresentativeState {
  final SingleOrderModel? singleOrderModel;

  GetSingleOrderSuccessStates({
    required this.singleOrderModel,
  });
}

final class GetSingleOrderErrorStates extends RepresentativeState {
  final String error;

  GetSingleOrderErrorStates({required this.error});
}

final class GetNextOrderLoadingStates extends RepresentativeState {}

final class GetNextOrderSuccessStates extends RepresentativeState {
  GetNextOrderSuccessStates();
}

final class GetNextOrderErrorStates extends RepresentativeState {
  final String error;

  GetNextOrderErrorStates({required this.error});
}

final class GetCurrentOrderLoadingStates extends RepresentativeState {}

final class GetCurrentOrderSuccessStates extends RepresentativeState {
  GetCurrentOrderSuccessStates();
}

final class GetCurrentOrderErrorStates extends RepresentativeState {
  final String error;

  GetCurrentOrderErrorStates({required this.error});
}

final class GetAllOrderLoadingStates extends RepresentativeState {}

final class GetAllOrderSuccessStates extends RepresentativeState {}

final class GetAllOrderErrorStates extends RepresentativeState {
  final String error;

  GetAllOrderErrorStates({required this.error});
}

final class GetFinishedOrderLoadingStates extends RepresentativeState {}

final class GetFinishedOrderSuccessStates extends RepresentativeState {}

final class GetFinishedOrderErrorStates extends RepresentativeState {
  final String error;

  GetFinishedOrderErrorStates({required this.error});
}

final class GetOrderReviewsLoadingStates extends RepresentativeState {}

final class GetOrderReviewsSuccessStates extends RepresentativeState {}

final class GetOrderReviewsErrorStates extends RepresentativeState {
  final String error;

  GetOrderReviewsErrorStates({required this.error});
}

final class GetOrderStatisTicsLoadingStates extends RepresentativeState {}

final class GetOrderStatisTicsSuccessStates extends RepresentativeState {}

final class GetOrderStatisTicsErrorStates extends RepresentativeState {
  final String error;

  GetOrderStatisTicsErrorStates({required this.error});
}

final class ApproveOrderLoadingStates extends RepresentativeState {}

final class ApproveOrderSuccessStates extends RepresentativeState {}

final class ApproveOrderErrorStates extends RepresentativeState {
  final String error;

  ApproveOrderErrorStates({required this.error});
}

final class FinishOrderLoadingStates extends RepresentativeState {}

final class FinishOrderSuccessStates extends RepresentativeState {}

final class FinishOrderErrorStates extends RepresentativeState {
  final String error;

  FinishOrderErrorStates({required this.error});
}

final class StartOrderLoadingStates extends RepresentativeState {}

final class StartOrderSuccessStates extends RepresentativeState {}

final class StartOrderErrorStates extends RepresentativeState {
  final String error;

  StartOrderErrorStates({required this.error});
}
