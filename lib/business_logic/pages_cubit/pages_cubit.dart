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

  void aboutUs() async {
    emit(AboutUsLoadingState());
    final response = await _pagesRemoteDataSource.aboutUs();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
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

        emit(
          AboutUsSuccessState(),
        );
      },
    );
  }

  void termsAndConditions() async {
    emit(TermsAndConditionsLoadingState());
    final response = await _pagesRemoteDataSource.termsAndConditions();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
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

        emit(
          TermsAndConditionsSuccessState(),
        );
      },
    );
  }

  void privacyPolicy() async {
    emit(PrivacyPolicyLoadingState());
    final response = await _pagesRemoteDataSource.privacyPolicy();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
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

        emit(
          PrivacyPolicySuccessState(),
        );
      },
    );
  }
}
