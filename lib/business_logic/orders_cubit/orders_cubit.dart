import 'package:car_wash/data/data_source/remote_data_source/orders_remote_data_source.dart';
import 'package:car_wash/data/models/car_types_model/car_types_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/network/error_message_model.dart';
import '../../core/services/services_locator.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  final OrdersRemoteDatasource _ordersRemoteDatasource = sl();

  static OrdersCubit get(context) => BlocProvider.of(context);

  BaseErrorModel? baseErrorModel;

  GetContentImageModel? carTypesModel;
  GetContentImageModel? servicesModel;
  ContentImageModel? carContentImageModel;
  int? currentIndex;
  void changeCarType(int index,ContentImageModel contentImageModel){
    currentIndex = index;
    carContentImageModel = contentImageModel;
    emit(ChangeCarType());
  }
  void getCarTypes() async {
    emit(GetCarTypesLoadingStates());
    final response = await _ordersRemoteDatasource.getCarTypes();

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetCarTypesErrorStates(error: l.baseErrorModel.message));
      },
      (r) {
        carTypesModel = r;
        emit(GetCarTypesSuccessStates());
      },
    );
  }

  void getServices() async {
    emit(GetServicesLoadingStates());
    final response = await _ordersRemoteDatasource.getServices();

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetServicesErrorStates(error: l.baseErrorModel.message));
      },
      (r) {
        servicesModel = r;
        emit(GetServicesSuccessStates());
      },
    );
  }
}
