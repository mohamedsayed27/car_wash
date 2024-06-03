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
final class GetSingleOrderSuccessStates extends RepresentativeState {}
final class GetSingleOrderErrorStates extends RepresentativeState {
  final String error;

  GetSingleOrderErrorStates({required this.error});
}