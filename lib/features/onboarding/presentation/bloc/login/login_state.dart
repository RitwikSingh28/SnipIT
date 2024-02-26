part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginViaEmailSuccessState extends LoginState {
  final UserResponseModel userResponseModel;
  List<Object> get props => [userResponseModel];

  const LoginViaEmailSuccessState({required this.userResponseModel});
}
