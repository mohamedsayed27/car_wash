part of 'address_cubit.dart';

sealed class AddressState {}

final class AddressInitial extends AddressState {}
final class GetAllAddressLoadingState extends AddressState {}
final class GetAllAddressErrorState extends AddressState {
  final String error;

  GetAllAddressErrorState({required this.error});
}
final class GetAllAddressSuccessState extends AddressState {}
