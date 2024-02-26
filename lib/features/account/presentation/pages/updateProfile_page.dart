import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/validators.dart';
import 'package:snipit/features/account/presentation/bloc/update_user_profile_event.dart';
import 'package:snipit/features/account/presentation/bloc/update_user_profile_state.dart';
import 'package:snipit/features/onboarding/domain/entities/update_user_details_entity.dart';
import 'package:snipit/features/onboarding/presentation/bloc/update_user_details/update_user_details_bloc.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/injection_container.dart';
import 'package:snipit/ui/molecules/custom_button.dart';
import 'package:snipit/ui/molecules/custom_scaffold.dart';
import 'package:snipit/ui/molecules/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/helpers/media_uploader.dart';
import '../../../../core/helpers/pick_image.dart';
import '../../../../core/helpers/user_helpers.dart';
import '../bloc/update_user_profile_bloc.dart';
import '../widgets/bottom_sheet_options.dart';

class UpdateProfilePage extends StatefulWidget {
  final bool isEditMode;

  const UpdateProfilePage({
    super.key,
    this.isEditMode = false,
  });

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _subscriberNumberController = TextEditingController();
  final _subscriberNumberFormattedController = TextEditingController();
  final _bloc = sl<UpdateUserProfileBloc>();

  late final Timer _timer;
  final _scrollController = ScrollController();
  bool _isKeyboardVisible = false;
  String _email = "";
  String? imageUrl;
  XFile? pickedImage;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var user = await UserHelpers.getUserDetails();
    imageUrl = user.photo;
    _firstNameController.text = user?.firstName ?? "";
    _lastNameController.text = user?.lastName ?? "";
    _emailController.text = user?.email ?? "";
    _subscriberNumberFormattedController.text = user?.phone ?? "";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _subscriberNumberController.dispose();
    _subscriberNumberFormattedController.dispose();
    _scrollController.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<UpdateUserProfileBloc, UpdateUserProfileState>(
        listener: (context, state) {
          if (state is UpdateUserProfileSuccess) {
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<UpdateUserProfileBloc, UpdateUserProfileState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: UiHelpers.hideKeyboard,
              child: CustomScaffold(
                body: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeadingSection(),
                            CustomSpacers.height15,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (c) {
                                          return BottomSheetOptions(
                                              selectImageFromCamera: () {
                                            pickImage(ImageSource.camera);
                                          }, selectImageFromGallery: () {
                                            pickImage(ImageSource.gallery);
                                          });
                                        });
                                  },
                                  child: _buildProfilePictureSection(
                                      imageFile: state.imageFile),
                                )
                              ],
                            ),
                            CustomSpacers.height15,
                            const Text(
                              'All fields with an * are required',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                                overflow: TextOverflow.ellipsis,
                                fontFamily: AppFontFamily.maisonNeue,
                              ),
                            ),
                            CustomSpacers.height26,
                            _buildForm(),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 10,
                      child: CustomButton(
                        strButtonText:
                            widget.isEditMode ? 'Edit profile' : 'Save profile',
                        buttonAction: () async {
                          _subscriberNumberController.text =
                              _subscriberNumberFormattedController.text
                                  .replaceAll(' ', '');
                          _submitForm();
                        },
                        textStyle: AppTextStyles.textStyles_MN_30_600_black
                            .copyWith(
                                fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeadingSection() {
    return const Text.rich(TextSpan(
        style: TextStyle(
          fontSize: 30,
          height: 40 / 30,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
          overflow: TextOverflow.ellipsis,
          fontFamily: AppFontFamily.maisonNeue,
        ),
        children: [
          TextSpan(
            text: 'Edit ',
          ),
          TextSpan(
              text: 'your profile',
              style: TextStyle(fontWeight: FontWeight.w600)),
        ]));
  }

  Widget _buildProfilePictureSection({required XFile? imageFile}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: imageFile != null
              ? FileImage(File(imageFile.path))
              : imageUrl != null
                  ? NetworkImage(imageUrl!) as ImageProvider
                  : null,
        ),
        CustomSpacers.height4,
        Text(
          'Change Picture',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
            overflow: TextOverflow.ellipsis,
            fontFamily: AppFontFamily.maisonNeue,
          ),
        )
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField.secondary(
            controller: _firstNameController,
            validator: Validators.name,
            title: 'First name*',
            hint: 'First name',
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            maxLines: 1,
          ),
          CustomSpacers.height36,
          CustomTextField.secondary(
            controller: _lastNameController,
            validator: Validators.name,
            title: 'Last name*',
            hint: 'Last name',
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            maxLines: 1,
          ),
          CustomSpacers.height36,
          CustomTextField.secondary(
            controller: _emailController,
            validator: Validators.email,
            title: 'Email*',
            hint: 'Email',
            disabled: _email != '',
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
          ),
          CustomSpacers.height36,
          CustomTextField.secondary(
            controller: _subscriberNumberFormattedController,
            validator: (_) =>
                Validators.phone(_subscriberNumberController.text),
            title: 'Contact number*',
            hint: 'Contact number',
            keyboardType: TextInputType.phone,
            maxLines: 1,
            prefixText: '🇬🇧 +44: ',
            textInputFormatter: MaskedInputFormatter('0000 000 000'),
          ),
          SizedBox(height: 200),
        ],
      ),
    );
  }

  _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String? profileUrl;
      if (pickedImage != null) {
        UiHelpers.showLoader();
        profileUrl = await MediaUploadHelper.uploadProfileImage(pickedImage!);
      }
      _bloc.add(PutUserProfileEvent(
          entity: UpdateUserDetailsEntity(
              photo: profileUrl ?? imageUrl,
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              email: _emailController.text,
              phone: _subscriberNumberController.text)));
    }
  }

  pickImage(ImageSource imageSource) async {
    Navigator.pop(context);
    pickedImage = await ImagePickerHelper.pickImage(imageSource: imageSource);
    if (pickedImage != null) {
      _bloc.add(PickImageEvent(pickedImage: pickedImage!));
    }
  }
}
