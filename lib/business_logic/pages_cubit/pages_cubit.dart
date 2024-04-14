import 'package:car_wash/core/network/error_message_model.dart';
import 'package:car_wash/data/data_source/remote_data_source/pages_remote_data_source.dart';
import 'package:car_wash/data/models/pages_model/base_pages_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/services_locator.dart';

part 'pages_state.dart';

class PagesCubit extends Cubit<PagesState> {
  PagesCubit() : super(PagesInitial());

  final PagesRemoteDataSource _pagesRemoteDataSource = sl();

  static PagesCubit get(context) => BlocProvider.of(context);

  BasePagesModel? basePagesModel;
  BaseErrorModel? baseErrorModel;
  bool getPageLoading = false;

  void aboutUs() async {
    getPageLoading = true;
    emit(AboutUsLoadingState());
    final response = await _pagesRemoteDataSource.aboutUs();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getPageLoading = false;
        emit(
          AboutUsErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        basePagesModel = r;
        getPageLoading = false;
        emit(
          AboutUsSuccessState(),
        );
      },
    );
  }

  void termsAndConditions() async {
    getPageLoading = true;
    emit(TermsAndConditionsLoadingState());
    final response = await _pagesRemoteDataSource.termsAndConditions();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getPageLoading = false;
        emit(
          TermsAndConditionsErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        basePagesModel = r;
        getPageLoading = false;
        emit(
          TermsAndConditionsSuccessState(),
        );
      },
    );
  }

  void privacyPolicy() async {
    getPageLoading = true;
    emit(PrivacyPolicyLoadingState());
    final response = await _pagesRemoteDataSource.privacyPolicy();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getPageLoading = false;
        emit(
          PrivacyPolicyErrorState(
            error: l.baseErrorModel.errors != null
                ? baseErrorModel!.errors![0]
                : l.baseErrorModel.message ?? "",
          ),
        );
      },
      (r) async {
        basePagesModel = r;
        getPageLoading = false;
        emit(
          PrivacyPolicySuccessState(),
        );
      },
    );
  }
}
