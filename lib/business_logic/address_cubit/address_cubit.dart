import 'package:car_wash/core/parameters/address_parameters/update_address_parameters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/network/error_message_model.dart';
import '../../core/parameters/address_parameters/add_address_parameters.dart';
import '../../core/services/services_locator.dart';
import '../../data/data_source/remote_data_source/address_remote_data_source.dart';
import '../../data/models/address_model/address_model.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  final AddressRemoteDatasource _addressRemoteDatasource = sl();

  static AddressCubit get(context) => BlocProvider.of(context);

  BaseErrorModel? baseErrorModel;

  GetAddressesModel? getAddressesModel;

  void getAddress() async {
    emit(GetAllAddressLoadingState());
    final response = await _addressRemoteDatasource.getAddress();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          GetAllAddressErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        getAddressesModel = r;
        emit(GetAllAddressSuccessState());
      },
    );
  }

  void addAddress({
    required AddAddressParameters addAddressParameters,
  }) async {
    emit(AddAddressLoadingState());
    final response = await _addressRemoteDatasource.addAddress(
        parameters: addAddressParameters);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          AddAddressErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        emit(AddAddressSuccessState());
      },
    );
  }

  void updateAddress({
    required UpdateAddressParameters updateAddressParameters,
  }) async {
    emit(UpdateAddressLoadingState());
    final response = await _addressRemoteDatasource.updateAddress(
        parameters: updateAddressParameters);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          UpdateAddressErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        emit(UpdateAddressSuccessState());
      },
    );
  }

  void deleteAddress({
    required String addressId,
  }) async {
    emit(DeleteAddressLoadingState());
    final response =
        await _addressRemoteDatasource.deleteAddress(addressId: addressId);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          DeleteAddressErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        emit(DeleteAddressSuccessState());
      },
    );
  }
}
