import 'package:car_wash/core/parameters/orders_parameters/add_orders_parameters.dart';
import 'package:car_wash/data/data_source/remote_data_source/orders_remote_data_source.dart';
import 'package:car_wash/data/models/base_response_model.dart';
import 'package:car_wash/data/models/car_types_model/car_types_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/network/error_message_model.dart';
import '../../core/services/services_locator.dart';
import '../../data/models/order_models/get_all_orders_model.dart';
import '../../data/models/order_models/single_order_model.dart';
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
  void removeSelection() {
    carCurrentIndex = null;
    carContentImageModel = null;
    emit(ChangeCarType());
  }

  void changeServicesType(int index, ContentImageModel contentImageModel) {
    servicesCurrentIndex = index;
    servicesContentImageModel = contentImageModel;
    emit(ChangeCarType());
  }

  void removeIndex() {
    servicesCurrentIndex = null;
    servicesContentImageModel = null;
    emit(ChangeCarType());
  }

  void changeSelectedDateScheduleModel(TimeScheduleModel timeScheduleModel) {
    selectedDateScheduleModel = timeScheduleModel;
    selectedTimeModel = null;
    emit(ChangeSelectedTimeSchedule());
  }

  TimeModel? selectedTimeModel;

  void changeSelectedTimeScheduleModel(TimeModel? timeScheduleModel) {
    selectedTimeModel = timeScheduleModel;
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
        getTimeScheduleLoading = false;
        emit(GetTimeScheduleErrorStates(error: l.baseErrorModel.message));
      },
      (r) {
        timeList = r.result ?? <TimeScheduleModel>[];
        getTimeScheduleLoading = false;
        emit(GetTimeScheduleSuccessStates());
      },
    );
  }

  bool addOrderLoading = false;

  void makeOrder({required AddOrderParameters addOrderParameters}) async {
    addOrderLoading = true;
    emit(MakeOrderLoadingState());
    final response =
        await _ordersRemoteDatasource.addOrder(parameters: addOrderParameters);
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
        emit(
          MakeOrderSuccessState(baseResponseModel: r),
        );
      },
    );
  }

  bool getSingleOrderLoading = false;
  SingleOrderModel? getSingleOrderModel;

  void getSingleOrder({required int id}) async {
    getSingleOrderLoading = true;
    emit(GetSingleOrderLoadingStates());
    final response = await _ordersRemoteDatasource.getSingleOrder(orderId: id);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getSingleOrderLoading = false;
        emit(GetSingleOrderErrorStates(error: l.baseErrorModel.message ?? ""));
      },
      (r) {
        getSingleOrderModel = r.result;
        getSingleOrderLoading = false;
        print(getSingleOrderModel?.orderRate);
        emit(GetSingleOrderSuccessStates(singleOrderModel: r.result));
      },
    );
  }

  bool deleteOrderLoading = false;
  SingleOrderModel? deleteOrderModel;

  void deleteOrder({required String id}) async {
    deleteOrderLoading = true;
    emit(DeleteOrderLoadingStates());
    final response = await _ordersRemoteDatasource.deleteOrder(orderId: id);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        deleteOrderLoading = false;
        emit(DeleteOrderErrorStates(error: l.baseErrorModel.message ?? ""));
      },
      (r) {
        deleteOrderModel = r.result;
        deleteOrderLoading = false;
        emit(DeleteOrderSuccessStates(baseResponseModel: r.result));
      },
    );
  }

  GetAllOrdersModel? getAllOrdersModel;
  bool getAllOrdersLoading = false;

  void getAllOrder() async {
    getAllOrdersLoading = true;
    emit(GetAllOrderLoadingStates());
    final response = await _ordersRemoteDatasource.getOrders();

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getAllOrdersLoading = false;
        emit(GetAllOrderErrorStates(error: l.baseErrorModel.message ?? ""));
      },
      (r) {
        getAllOrdersModel = r;
        getAllOrdersLoading = false;
        emit(GetAllOrderSuccessStates());
      },
    );
  }

  void rateOrder({
    required String orderId,
    required String rate,
    required String review,
  }) async {
    emit(RateOrderLoadingStates());
    final response = await _ordersRemoteDatasource.rateOrder(
      orderId: orderId,
      rate: rate,
      review: review,
    );

    print(response);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(RateOrderErrorStates(error: l.baseErrorModel.message ?? ""));
      },
      (r) {
        getAllOrdersLoading = false;
        emit(RateOrderSuccessStates());
      },
    );
  }

  int rating = 0;

  updateRating(value) {
    rating = value.round();
  }
}
