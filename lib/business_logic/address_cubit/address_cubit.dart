import 'package:car_wash/data/models/address_model/address_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/network/error_message_model.dart';
import '../../core/services/services_locator.dart';
import '../../data/data_source/remote_data_source/address_remote_data_source.dart';

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
}
