import 'package:equatable/equatable.dart';
import 'package:snipit/features/onboarding/domain/entities/change_password_entity.dart';
import 'package:snipit/features/onboarding/domain/entities/submit_email_entity.dart';

import '../../../domain/entities/verify-otp-event.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class EmailSubmitEvent extends ForgotPasswordEvent {
  final SubmitEmailEntity entity;
  const EmailSubmitEvent({required this.entity});
}

class ResendOtpEvent extends ForgotPasswordEvent {
  final SubmitEmailEntity entity;
  const ResendOtpEvent({required this.entity});
}

class OtpSubmitEvent extends ForgotPasswordEvent{
  final VerifyOtpEntity entity;
  const OtpSubmitEvent({required this.entity});
}

class CreateNewPasswordEvent extends ForgotPasswordEvent{
  final ChangePasswordEntity entity;
  const CreateNewPasswordEvent({required this.entity});
}