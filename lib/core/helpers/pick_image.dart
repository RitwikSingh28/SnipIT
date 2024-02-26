import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class ImagePickerHelper{

  static Future<XFile?> pickImage({required ImageSource imageSource}) async{
    Map<Permission, PermissionStatus> statuses =
    await [Permission.camera, Permission.storage].request();
    print("Asked for permission");
    if (statuses[Permission.camera] != PermissionStatus.granted &&
    statuses[Permission.storage] != PermissionStatus.granted) {
    return null;
    }

    return await ImagePicker().pickImage(source: imageSource);


}}