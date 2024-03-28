part of 'plans_cubit.dart';

sealed class PlansState {}

final class PlansInitial extends PlansState {}
final class ChangeUserPlansState extends PlansState {}
final class ChangePlansState extends PlansState {}


final class GetAllPlansLoadingState extends PlansState {}
final class GetAllPlansSuccessState extends PlansState {}
final class GetAllPlansErrorState extends PlansState {
  final String error;

  GetAllPlansErrorState({required this.error});
}


final class GetUserPlansLoadingState extends PlansState {}
final class GetUserPlansSuccessState extends PlansState {}
final class GetUserPlansErrorState extends PlansState {
  final String error;

  GetUserPlansErrorState({required this.error});
}


final class SubscribePlanLoadingState extends PlansState {}
final class SubscribePlanSuccessState extends PlansState {}
final class SubscribePlanErrorState extends PlansState {
  final String error;

  SubscribePlanErrorState({required this.error});
}


final class UnSubscribePlanLoadingState extends PlansState {}
final class UnSubscribePlanSuccessState extends PlansState {}
final class UnSubscribePlanErrorState extends PlansState {
  final String error;

  UnSubscribePlanErrorState({required this.error});
}