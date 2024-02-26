import 'package:image_picker/image_picker.dart';

import '../../../onboarding/domain/entities/update_user_details_entity.dart';

abstract class UpdateUserProfileEvent{}


class PutUserProfileEvent extends  UpdateUserProfileEvent{
  final XFile? pickedFile;
  final UpdateUserDetailsEntity entity;

  PutUserProfileEvent({required this.entity,this.pickedFile});
}

class PickImageEvent extends UpdateUserProfileEvent{
  XFile pickedImage;
  PickImageEvent({required this.pickedImage});
}