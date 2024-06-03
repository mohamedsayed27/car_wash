import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/network/error_message_model.dart';
import '../../core/services/services_locator.dart';
import '../../data/data_source/remote_data_source/representitive_remote_data_source.dart';
import '../../data/models/base_response_model.dart';

part 'representative_state.dart';

class RepresentativeCubit extends Cubit<RepresentativeState> {
  final RepresentativeDatasource _representativeDatasource = sl();
  RepresentativeCubit() : super(RepresentativeInitial());

  static RepresentativeCubit get(context) => BlocProvider.of(context);

  BaseErrorModel? baseErrorModel;
  BaseResponseModel? baseResponseModel;


  void getSingleOrder({required String id}) async {
    emit(GetSingleOrderLoadingStates());
    final response = await _representativeDatasource.getSingleOrder(id: id);

    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetSingleOrderErrorStates(error: l.baseErrorModel.message??""));
      },
          (r) {

        emit(GetSingleOrderSuccessStates());
      },
    );
  }
  void approveOrder({required String id}) async {
    emit(GetSingleOrderLoadingStates());
    final response = await _representativeDatasource.approveOrder(id: id);

    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetSingleOrderErrorStates(error: l.baseErrorModel.message??""));
      },
          (r) {

        emit(GetSingleOrderSuccessStates());
      },
    );
  }
  void startOrder({required String id}) async {
    emit(GetSingleOrderLoadingStates());
    final response = await _representativeDatasource.startOrder(id: id);

    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetSingleOrderErrorStates(error: l.baseErrorModel.message??""));
      },
          (r) {

        emit(GetSingleOrderSuccessStates());
      },
    );
  }
  void finishOrder({required String id}) async {
    emit(GetSingleOrderLoadingStates());
    final response = await _representativeDatasource.finishOrder(id: id);

    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetSingleOrderErrorStates(error: l.baseErrorModel.message??""));
      },
          (r) {

        emit(GetSingleOrderSuccessStates());
      },
    );
  }
  void getAllOrder() async {
    emit(GetSingleOrderLoadingStates());
    final response = await _representativeDatasource.getMyOrders();

    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetSingleOrderErrorStates(error: l.baseErrorModel.message??""));
      },
          (r) {

        emit(GetSingleOrderSuccessStates());
      },
    );
  }
  void getOrderStatistics() async {
    emit(GetSingleOrderLoadingStates());
    final response = await _representativeDatasource.getOrderStatistics();

    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetSingleOrderErrorStates(error: l.baseErrorModel.message??""));
      },
          (r) {

        emit(GetSingleOrderSuccessStates());
      },
    );
  }
}
