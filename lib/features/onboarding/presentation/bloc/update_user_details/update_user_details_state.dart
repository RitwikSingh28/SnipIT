part of 'update_user_details_bloc.dart';


class UpdateUserDetailsState extends Equatable {
  final XFile? imageFile;
  const UpdateUserDetailsState({this.imageFile});

  @override
  List<Object> get props => [];

  UpdateUserDetailsState copyWith({XFile? pickedFile}){
    return UpdateUserDetailsState(imageFile: pickedFile);
  }

}

final class UpdateUserDetailsInitial extends UpdateUserDetailsState {}

class UpdateUserDetailsSuccessState extends UpdateUserDetailsState {
  final UpdateUserDetailsModel userDetailsModel;

  const UpdateUserDetailsSuccessState({required this.userDetailsModel});
}

class UploadProfilePicLoadingState extends UpdateUserDetailsState{}
class UploadProfilePicSuccessState extends UpdateUserDetailsState{}
class UploadProfilePicFailureState extends UpdateUserDetailsState{}
