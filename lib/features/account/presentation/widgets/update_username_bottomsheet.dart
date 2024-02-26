import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/screen_utils.dart';

import '../../../../core/utils/custom_spacers.dart';
import '../../../../core/validators.dart';
import '../../../../ui/injection_container.dart';
import '../../../../ui/molecules/custom_button.dart';
import '../../../../ui/molecules/custom_text_field.dart';
import '../../domain/entities/update_username_entity.dart';
import '../bloc/update_user_name_bloc.dart';
import '../bloc/update_user_name_event.dart';
import '../bloc/update_user_name_state.dart';

class UpdateUserNameBottomSheet extends StatefulWidget {
  const UpdateUserNameBottomSheet({Key? key}) : super(key: key);

  @override
  State<UpdateUserNameBottomSheet> createState() =>
      _UpdateUserNameBottomSheetState();
}

class _UpdateUserNameBottomSheetState extends State<UpdateUserNameBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _bloc = sl<UpdateUserNameBloc>();
  String userNameAvailabilityText = '';
  bool isUserNameAvailable = false;
  bool isDisabled = true;

  @override
  void dispose() async {
    print("Dispose Called");
    // TODO: implement dispose
    super.dispose();
    await _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<UpdateUserNameBloc, UpdateUserNameState>(
        listener: (context, state) {
          if (state is UpdateUserNameSuccessState) {
            Navigator.pop(context);
          }
          if (state is UserNameAvailableState) {
            userNameAvailabilityText = state.loaded.message!;
            isUserNameAvailable = state.loaded.success ?? false;
          }
        },
        child: SizedBox(
          height: 250.h,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<UpdateUserNameBloc, UpdateUserNameState>(
              builder: (context, state) {
                return Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Update Username',
                          style: AppTextStyles.textStyles_MN_30_600_black
                              .copyWith(fontSize: 22)),
                      CustomSpacers.height10,
                      CustomTextField.primary(
                        controller: _userNameController,
                        hint: "Enter User Name",
                        validator: (value) => Validators.username(value),
                        onChanged: (value) {
                          if (value.length > 4) {
                            checkUserNameAvailability(userName: value);
                          } else {
                            isUserNameAvailable = false;
                          }
                        },
                      ),
                      // Text(userNameAvailabilityText),
                      CustomSpacers.height6,
                      BlocBuilder<UpdateUserNameBloc, UpdateUserNameState>(
                        builder: (context, state) {
                          if (state is UserNameNotAvailableState) {
                            return Text(
                              "${_userNameController.text} not available",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.red),
                            );
                          }
                          return Container();
                        },
                      ),
                      Spacer(),
                      CustomButton(
                          isDisabled: !isUserNameAvailable,
                          //isDisabled,
                          strButtonText: "Update User Name",
                          buttonAction: () {
                            if (_formKey.currentState!.validate()) {
                              if (_bloc.state is UserNameAvailableState) {
                                updateUserName(
                                    userName: _userNameController.text);
                              }
                              checkUserNameAvailability(
                                  userName: _userNameController.text);
                            }
                          })
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  checkUserNameAvailability({required String userName}) {
    CheckUserNameEntity entity = CheckUserNameEntity(username: userName);
    _bloc.add(CheckUserName(entity: entity));
  }

  updateUserName({required String userName}) {
    _bloc.add(UpdateUserName(userName: userName));
  }
}
