import 'package:car_wash/core/parameters/orders_parameters/add_orders_parameters.dart';
import 'package:car_wash/data/data_source/remote_data_source/orders_remote_data_source.dart';
import 'package:car_wash/data/models/base_response_model.dart';
import 'package:car_wash/data/models/car_types_model/car_types_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/network/error_message_model.dart';
import '../../core/services/services_locator.dart';
import '../../data/models/time_schedule/time_schedule.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  final OrdersRemoteDatasource _ordersRemoteDatasource = sl();

  static OrdersCubit get(context) => BlocProvider.of(context);

  BaseErrorModel? baseErrorModel;

  GetContentImageModel? carTypesModel;
  GetContentImageModel? servicesModel;
  ContentImageModel? carContentImageModel;
  int? carCurrentIndex;
  ContentImageModel? servicesContentImageModel;
  int? servicesCurrentIndex;

  void changeCarType(int index, ContentImageModel contentImageModel) {
    carCurrentIndex = index;
    carContentImageModel = contentImageModel;
    emit(ChangeCarType());
  }

  void changeServicesType(int index, ContentImageModel contentImageModel) {
    servicesCurrentIndex = index;
    servicesContentImageModel = contentImageModel;
    emit(ChangeCarType());
  }

  void changeSelectedDateScheduleModel(TimeScheduleModel timeScheduleModel) {
    selectedDateScheduleModel = timeScheduleModel;
    print(selectedDateScheduleModel?.id);
    selectedTimeModel = null;
    emit(ChangeSelectedTimeSchedule());
  }

  TimeModel? selectedTimeModel;
  void changeSelectedTimeScheduleModel(TimeModel? timeScheduleModel) {
    selectedTimeModel = timeScheduleModel;
    print(selectedTimeModel?.id);
    emit(ChangeSelectedTimeSchedule());
  }

  bool getCarTypesLoading = false;
  void getCarTypes() async {
    getCarTypesLoading = true;
    emit(GetCarTypesLoadingStates());
    final response = await _ordersRemoteDatasource.getCarTypes();

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getCarTypesLoading = false;
        emit(GetCarTypesErrorStates(error: l.baseErrorModel.message));
      },
      (r) {
        carTypesModel = r;
        getCarTypesLoading = false;
        emit(GetCarTypesSuccessStates());
      },
    );
  }

  bool getServicesLoading = false;

  void getServices() async {
    getServicesLoading = true;
    emit(GetServicesLoadingStates());
    final response = await _ordersRemoteDatasource.getServices();

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getServicesLoading = false;
        emit(GetServicesErrorStates(error: l.baseErrorModel.message));
      },
      (r) {
        servicesModel = r;
        getServicesLoading = false;
        emit(GetServicesSuccessStates());
      },
    );
  }


  bool getTimeScheduleLoading = false;
  List<TimeScheduleModel> timeList = [];
  TimeScheduleModel? selectedDateScheduleModel;
  void getTimeSchedule() async {
    getTimeScheduleLoading = true;
    emit(GetTimeScheduleLoadingStates());
    final response = await _ordersRemoteDatasource.getTimeSchedule();

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        print(baseErrorModel);
        getTimeScheduleLoading = false;
        emit(GetTimeScheduleErrorStates(error: l.baseErrorModel.message));
      },
      (r) {
        timeList = r.result??<TimeScheduleModel>[];
        getTimeScheduleLoading = false;
        print(timeList);
        emit(GetTimeScheduleSuccessStates());
      },
    );
  }



  bool addOrderLoading = false;
  void makeOrder({required AddOrderParameters addOrderParameters}) async {
    addOrderLoading = true;
    emit(MakeOrderLoadingState());
    final response = await _ordersRemoteDatasource.addOrder(parameters: addOrderParameters);
    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        addOrderLoading = false;
        emit(
          MakeOrderErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
          (r) async {
            addOrderLoading = false;
        emit(MakeOrderSuccessState(baseResponseModel: r),);
      },
    );
  }
}
