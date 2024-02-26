import 'package:snipit/features/account/data/models/update_user_name_response_model.dart';

abstract class UpdateUserNameState {}

class UpdateUserNameInitialState extends UpdateUserNameState {}

class UserNameAvailableState extends UpdateUserNameState {
  final UpdateUserNameModel loaded;
  UserNameAvailableState({required this.loaded});
}

class UserNameNotAvailableState extends UpdateUserNameState {}

class UpdateUserNameSuccessState extends UpdateUserNameState {}

class UpdateUserNameFailureState extends UpdateUserNameState {}
