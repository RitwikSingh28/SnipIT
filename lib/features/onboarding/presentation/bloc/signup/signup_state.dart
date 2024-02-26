part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupState {}

class RegisterViaEmailSuccessState extends SignupState {
  final RegisterResponseModel registerResponse;
  const RegisterViaEmailSuccessState({required this.registerResponse});
}

class OtpVerifiedState extends SignupState {
  final VerifyOtpResponse response;
  const OtpVerifiedState({required this.response});
}

class SocialAuthSuccessState extends SignupState {
  final SocialAuthModel model;
  const SocialAuthSuccessState({required this.model});
}
