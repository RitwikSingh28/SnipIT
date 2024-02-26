import 'package:snipit/features/account/domain/entities/update_username_entity.dart';

abstract class UpdateUserNameEvent{}

class CheckUserName extends UpdateUserNameEvent{
  final CheckUserNameEntity entity;
  CheckUserName({required this.entity});
}

class UpdateUserName extends UpdateUserNameEvent{
  final String userName;
  UpdateUserName({required this.userName});
}