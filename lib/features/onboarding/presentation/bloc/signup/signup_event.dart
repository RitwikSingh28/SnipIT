part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class RegisterViaEmailEvent extends SignupEvent {
  final RegisterEmailEntity entity;
  const RegisterViaEmailEvent({required this.entity});
}

class VerifyOtpEvent extends SignupEvent {
  final VerifyOtpEntity entity;
  const VerifyOtpEvent({required this.entity});
}

class RegisterViaOAuthEvent extends SignupEvent {
  final SocialAuthEntity entity;
  const RegisterViaOAuthEvent({required this.entity});
}
