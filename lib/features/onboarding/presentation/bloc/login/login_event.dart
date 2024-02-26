part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginViaEmailEvent extends LoginEvent {
  final EmailLoginEntity entity;

  const LoginViaEmailEvent({required this.entity});
}
