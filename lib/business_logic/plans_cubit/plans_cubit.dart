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
  AllPlansModel? userPlansModel;
  AllPlansModel? selectedSubscribePlan;
  List<AllPlansModel> plansList = [];
  List<AllPlansModel> userNotSubscribedPlansList = [];
  int? userPlansCurrentIndex;
  int? selectedPlanIndex;

  void changePlan(int index, AllPlansModel userPlansModel) {
    userPlansCurrentIndex = index;
    this.userPlansModel = userPlansModel;
    emit(ChangeUserPlansState());
  }


  void removeIndex() {
    userPlansCurrentIndex = null;
    userPlansModel=null;
    emit(ChangeUserPlansState());
  }
  // void selectedSubscribePlanIndex(int index, AllPlansModel selectedSubscribePlan) {
  //   selectedPlanIndex = index;
  //   this.selectedSubscribePlan = selectedSubscribePlan;
  //   emit(ChangeUserPlansState());
  // }

  bool getUserPlansLoading = false;

  void getAllPlans() async {
    getUserPlansLoading = true;
    emit(GetAllPlansLoadingState());
    final response = await _plansRemoteDatasource.getAllPlans();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getUserPlansLoading = false;
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
        print(getAllPlansModel?.result);
        plansList = r.result??[];
        print(plansList.where((element)=>element.isSubscribed==1));
        getUserPlansLoading = false;
        emit(GetAllPlansSuccessState());
      },
    );
  }

  bool subscribePlanLoading = false;
  void subscribePlan({required String planId}) async {
    subscribePlanLoading = true;
    emit(SubscribePlanLoadingState());
    final response = await _plansRemoteDatasource.subscribePlan(planId: planId);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        subscribePlanLoading = false;
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
        subscribePlanLoading = false;
        emit(SubscribePlanSuccessState());
      },
    );
  }

  void unSubscribePlan({required String planId}) async {
    emit(UnSubscribePlanLoadingState());
    final response =
        await _plansRemoteDatasource.unSubscribePlan(planId: planId);
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
