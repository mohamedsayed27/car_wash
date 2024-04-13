part of 'address_cubit.dart';

sealed class AddressState {}

final class AddressInitial extends AddressState {}

final class ChangeSelectedAddress extends AddressState {}
final class OnMapTapped extends AddressState {}
final class GetCurrentMarker extends AddressState {}
final class GetCurrentLocation extends AddressState {}
final class AddMarker extends AddressState {}
final class GetLocationLoading extends AddressState {}
final class AnimateGetCurrentLocation extends AddressState {}
final class GetAllAddressLoadingState extends AddressState {}
final class GetAllAddressErrorState extends AddressState {
  final String error;

  GetAllAddressErrorState({required this.error});
}
final class GetAllAddressSuccessState extends AddressState {}

final class AddAddressLoadingState extends AddressState {}
final class AddAddressErrorState extends AddressState {
  final String error;

  AddAddressErrorState({required this.error});
}
final class AddAddressSuccessState extends AddressState {}

final class UpdateAddressLoadingState extends AddressState {}
final class UpdateAddressErrorState extends AddressState {
  final String error;

  UpdateAddressErrorState({required this.error});
}
final class UpdateAddressSuccessState extends AddressState {}

final class DeleteAddressLoadingState extends AddressState {}
final class DeleteAddressErrorState extends AddressState {
  final String error;

  DeleteAddressErrorState({required this.error});
}
final class DeleteAddressSuccessState extends AddressState {}
