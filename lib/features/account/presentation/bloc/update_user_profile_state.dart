import 'package:image_picker/image_picker.dart';

 class UpdateUserProfileState{
  final XFile? imageFile;
  const UpdateUserProfileState({this.imageFile});

  UpdateUserProfileState copyWith({XFile? pickedFile}){
    return UpdateUserProfileState(imageFile: pickedFile);
  }
}

final class UpdateUserProfileInitial extends  UpdateUserProfileState{}
final class UpdateUserProfileSuccess extends  UpdateUserProfileState{}
final class UpdateUserProfileFailure extends  UpdateUserProfileState{}