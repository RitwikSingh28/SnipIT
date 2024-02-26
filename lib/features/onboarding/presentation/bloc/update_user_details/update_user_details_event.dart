part of 'update_user_details_bloc.dart';

sealed class UpdateUserDetailsEvent extends Equatable {
  const UpdateUserDetailsEvent();

  @override
  List<Object> get props => [];
}

class PutUserDetailsEvent extends UpdateUserDetailsEvent {
  final XFile? pickedFile;
  final UpdateUserDetailsEntity entity;

  const PutUserDetailsEvent({required this.entity,this.pickedFile});
}

class UploadProfilePicEvent extends UpdateUserDetailsEvent{
  final ImageSource imageSource;
  const UploadProfilePicEvent({required this.imageSource});
}

class GetUserDetailById extends UpdateUserDetailsEvent{}
class ImagePickedEvent extends UpdateUserDetailsEvent{
  XFile pickedImage;
  ImagePickedEvent({required this.pickedImage});
}


