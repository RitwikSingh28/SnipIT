import 'package:equatable/equatable.dart';

sealed class ForgotPasswordState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ForgotPasswordInitialState extends ForgotPasswordState{}
class EmailRegisteredState extends ForgotPasswordState{}
class OtpVerifiedState extends ForgotPasswordState{}
class PasswordChangeSuccessState extends ForgotPasswordState{}