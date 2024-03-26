import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/network/error_message_model.dart';
import '../../core/services/services_locator.dart';
import '../../data/data_source/remote_data_source/plans_remote_datasource.dart';
import '../../data/models/base_response_model.dart';
import '../../data/models/plans_model/all_plans_model.dart';
import '../../data/models/plans_model/user_plans_model.dart';

part 'plans_state.dart';

class PlansCubit extends Cubit<PlansState> {
  PlansCubit() : super(PlansInitial());


  final PlansRemoteDatasource _plansRemoteDatasource = sl();

  static PlansCubit get(context) => BlocProvider.of(context);

  BaseErrorModel? baseErrorModel;
  BaseResponseModel? baseResponseModel;
  GetAllPlansModel? getAllPlansModel;
  GetUserPlansModel? getUserPlansModel;
  void getAllPlans() async {
    emit(GetAllPlansLoadingState());
    final response = await _plansRemoteDatasource.getAllPlans();
    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          GetAllPlansErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
          (r) async {
            getAllPlansModel = r;
        emit(GetAllPlansSuccessState());
      },
    );
  }


  void getUserPlans() async {
    emit(GetUserPlansLoadingState());
    final response = await _plansRemoteDatasource.getUserPlans();
    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          GetUserPlansErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
          (r) async {
            getUserPlansModel = r;
        emit(GetUserPlansSuccessState());
      },
    );
  }


  void subscribePlan({required String planId}) async {
    emit(SubscribePlanLoadingState());
    final response = await _plansRemoteDatasource.subscribePlan(planId: planId);
    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          SubscribePlanErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
          (r) async {
            baseResponseModel = r;
        emit(SubscribePlanSuccessState());
      },
    );
  }


  void unSubscribePlan({required String planId}) async {
    emit(UnSubscribePlanLoadingState());
    final response = await _plansRemoteDatasource.unSubscribePlan(planId: planId);
    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        emit(
          UnSubscribePlanErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
          (r) async {
            baseResponseModel = r;
        emit(UnSubscribePlanSuccessState());
      },
    );
  }
}
