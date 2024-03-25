part of 'pages_cubit.dart';

sealed class PagesState {}

final class PagesInitial extends PagesState {}

final class AboutUsLoadingState extends PagesState {}
final class AboutUsSuccessState extends PagesState {}
final class AboutUsErrorState extends PagesState {
  final String error;

  AboutUsErrorState({required this.error});
}

final class TermsAndConditionsLoadingState extends PagesState {}
final class TermsAndConditionsSuccessState extends PagesState {}
final class TermsAndConditionsErrorState extends PagesState {
  final String error;

  TermsAndConditionsErrorState({required this.error});
}

final class PrivacyPolicyLoadingState extends PagesState {}
final class PrivacyPolicySuccessState extends PagesState {}
final class PrivacyPolicyErrorState extends PagesState {
  final String error;

  PrivacyPolicyErrorState({required this.error});
}
