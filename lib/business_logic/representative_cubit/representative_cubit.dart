import 'package:car_wash/data/models/review_model/get_all_reviews_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../core/network/error_message_model.dart';
import '../../core/services/services_locator.dart';
import '../../data/data_source/remote_data_source/representitive_remote_data_source.dart';
import '../../data/models/base_response_model.dart';
import '../../data/models/order_models/get_all_orders_model.dart';
import '../../data/models/order_models/single_order_model.dart';

part 'representative_state.dart';

class RepresentativeCubit extends Cubit<RepresentativeState> {
  final RepresentativeDatasource _representativeDatasource = sl();

  RepresentativeCubit() : super(RepresentativeInitial());

  static RepresentativeCubit get(context) => BlocProvider.of(context);

  BaseErrorModel? baseErrorModel;
  BaseResponseModel? baseResponseModel;

  GetSingleOrdersModel? getNextOrdersModel;
  GetSingleOrdersModel? getCurrentOrderModel;
  bool getNextOrderLoading = false;

  final format = DateFormat.MMMEd('ar');
  final format1 = DateFormat.jm('ar');
  String nextOrder = "";
  String currentOrder = "";

  GetAllOrdersModel? getAllOrdersModel;
  bool getAllOrdersLoading = false;

  GetAllOrdersModel? getFinishedOrdersModel;
  bool getFinishedOrdersLoading = false;

  GetAllOrderReviewsModel? getAllOrderReviewsModel;
  bool getAllOrderReviewsLoading = false;

  bool getSingleOrderLoading = false;
  SingleOrderModel? getSingleOrderModel;
  void getSingleOrder({required String id}) async {
    getSingleOrderLoading = true;
    emit(GetSingleOrderLoadingStates());
    final response = await _representativeDatasource.getSingleOrder(id: id);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getSingleOrderLoading = false;
        emit(GetSingleOrderErrorStates(error: l.baseErrorModel.message ?? ""));
      },
      (r) {
        getSingleOrderModel = r.result;
        getSingleOrderLoading = false;
        emit(GetSingleOrderSuccessStates(singleOrderModel: r.result));
      },
    );
  }

  void getNextOrder() async {
    getNextOrderLoading = true;
    emit(GetNextOrderLoadingStates());
    final response = await _representativeDatasource.getNextOrder();

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getNextOrderLoading = false;
        emit(GetNextOrderErrorStates(error: l.baseErrorModel.message ?? ""));
      },
      (r) {
        getNextOrdersModel = r;
        getNextOrderLoading = false;
        nextOrder = r.result?.scheduleTime!=null?"${format.format(DateTime.parse("${getNextOrdersModel?.result?.scheduleTime?.date} ${getNextOrdersModel?.result?.scheduleTime?.time}"))} ${format1.format(DateTime.parse("${getNextOrdersModel?.result?.scheduleTime?.date} ${getNextOrdersModel?.result?.scheduleTime?.time}"))}":"";
        emit(GetNextOrderSuccessStates());
      },
    );
  }

  bool getCurrentOrderLoading = false;
  void getCurrentOrder() async {
    getCurrentOrderLoading = true;
    emit(GetCurrentOrderLoadingStates());
    final response = await _representativeDatasource.getCurrentOrder();

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getCurrentOrderLoading = false;
        emit(GetCurrentOrderErrorStates(error: l.baseErrorModel.message ?? ""));
      },
      (r) {

        getCurrentOrderModel = r;
        getCurrentOrderLoading = false;
        currentOrder =
        "${format.format(DateTime.parse("${getCurrentOrderModel?.result?.scheduleTime?.date} ${getCurrentOrderModel?.result?.scheduleTime?.time}"))} ${format1.format(DateTime.parse("${getCurrentOrderModel?.result?.scheduleTime?.date} ${getCurrentOrderModel?.result?.scheduleTime?.time}"))}";

        emit(GetCurrentOrderSuccessStates());
      },
    );
  }

  void approveOrder({required String id}) async {
    emit(ApproveOrderLoadingStates());
    final response = await _representativeDatasource.approveOrder(id: id);

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(ApproveOrderErrorStates(error: l.baseErrorModel.message ?? ""));
      },
      (r) {
        emit(ApproveOrderSuccessStates());
      },
    );
  }

  bool startOrderLoading = false;
  void startOrder({required String id}) async {
    startOrderLoading = true;
    emit(StartOrderLoadingStates());
    final response = await _representativeDatasource.startOrder(id: id);

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        startOrderLoading = false;
        emit(StartOrderErrorStates(error: l.baseErrorModel.message ?? ""));
      },
      (r) {
        startOrderLoading = false;
        emit(StartOrderSuccessStates());
      },
    );
  }

  void finishOrder({required String id}) async {
    emit(FinishOrderLoadingStates());
    final response = await _representativeDatasource.finishOrder(id: id);

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(FinishOrderErrorStates(error: l.baseErrorModel.message ?? ""));
      },
      (r) {
        emit(FinishOrderSuccessStates());
      },
    );
  }

  void getAllOrder() async {
    getAllOrdersLoading = true;
    emit(GetAllOrderLoadingStates());
    final response = await _representativeDatasource.getMyOrders();

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

  void getFinishedOrder() async {
    getFinishedOrdersLoading = true;
    emit(GetFinishedOrderLoadingStates());
    final response = await _representativeDatasource.getFinishedOrders();

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getFinishedOrdersLoading = false;
        emit(
            GetFinishedOrderErrorStates(error: l.baseErrorModel.message ?? ""));
      },
      (r) {
        getFinishedOrdersModel = r;
        getFinishedOrdersLoading = false;
        emit(GetFinishedOrderSuccessStates());
      },
    );
  }

  void getOrderReviews() async {
    getAllOrderReviewsLoading = true;
    emit(GetOrderReviewsLoadingStates());
    final response = await _representativeDatasource.getOrderReviews();

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getAllOrderReviewsLoading = false;
        emit(GetOrderReviewsErrorStates(error: l.baseErrorModel.message ?? ""));
      },
      (r) {
        getAllOrderReviewsModel = r;
        getAllOrderReviewsLoading = false;
        emit(GetOrderReviewsSuccessStates());
      },
    );
  }

  void getOrderStatistics() async {
    emit(GetOrderStatisTicsLoadingStates());
    final response = await _representativeDatasource.getOrderStatistics();

    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetOrderStatisTicsErrorStates(
            error: l.baseErrorModel.message ?? ""));
      },
      (r) {
        emit(GetOrderStatisTicsSuccessStates());
      },
    );
  }
}
