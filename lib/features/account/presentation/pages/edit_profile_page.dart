import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/validators.dart';
import 'package:snipit/features/onboarding/domain/entities/update_user_details_entity.dart';
import 'package:snipit/features/onboarding/presentation/bloc/update_user_details/update_user_details_bloc.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/injection_container.dart';
import 'package:snipit/ui/molecules/custom_button.dart';
import 'package:snipit/ui/molecules/custom_scaffold.dart';
import 'package:snipit/ui/molecules/custom_text_field.dart';

import '../../../../core/constants/app_text_styles.dart';

class EditProfilePage extends StatefulWidget {
  final bool isEditMode;

  const EditProfilePage({
    super.key,
    this.isEditMode = false,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _subscriberNumberController = TextEditingController();
  final _subscriberNumberFormattedController = TextEditingController();
  final _bloc = sl<UpdateUserDetailsBloc>();

  late final Timer _timer;
  final _scrollController = ScrollController();
  bool _isKeyboardVisible = false;
  String _email = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final Map<String, dynamic> args =
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      _email = args["email"];
      _emailController.text = _email;
      setState(() {});
      // _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      //   final bool newValue = UiHelpers.keyboardHeight > 0;
      //   if (newValue != _isKeyboardVisible) {
      //     _isKeyboardVisible = newValue;
      //     if (_isKeyboardVisible && _scrollController.hasClients) {
      //       _scrollController.jumpTo(
      //         _scrollController.position.maxScrollExtent,
      //       );
      //     }
      //   }
      // });
    });
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
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<UpdateUserDetailsBloc, UpdateUserDetailsState>(
        listener: (context, state) {
          if (state is UpdateUserDetailsSuccessState) {
            CustomNavigator.pushTo(context, AppPages.loading);
          }
        },
        child: BlocBuilder<UpdateUserDetailsBloc, UpdateUserDetailsState>(
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
                            Text.rich(TextSpan(
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
                                    text: 'Welcome! create ',
                                  ),
                                  TextSpan(
                                      text: 'your profile',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ])),
                            CustomSpacers.height15,
                            Text(
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
                            Form(
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
                                    textCapitalization:
                                    TextCapitalization.words,
                                    maxLines: 1,
                                  ),
                                  CustomSpacers.height36,
                                  CustomTextField.secondary(
                                    controller: _lastNameController,
                                    validator: Validators.name,
                                    title: 'Last name*',
                                    hint: 'Last name',
                                    keyboardType: TextInputType.name,
                                    textCapitalization:
                                    TextCapitalization.words,
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
                                    controller:
                                    _subscriberNumberFormattedController,
                                    validator: (_) => Validators.phone(
                                        _subscriberNumberController.text),
                                    title: 'Contact number*',
                                    hint: 'Contact number',
                                    keyboardType: TextInputType.phone,
                                    maxLines: 1,
                                    prefixText: '🇬🇧 +44: ',
                                    textInputFormatter:
                                    MaskedInputFormatter('0000 000 000'),
                                  ),
                                  SizedBox(height: 200),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 10,
                      child: CustomButton(
                        strButtonText: widget.isEditMode
                            ? 'Edit profile'
                            : 'Complete profile',
                        buttonAction: () {
                          _subscriberNumberController.text =
                              _subscriberNumberFormattedController.text
                                  .replaceAll(' ', '');
                          if (_formKey.currentState!.validate()) {
                            _bloc.add(PutUserDetailsEvent(
                                entity: UpdateUserDetailsEntity(
                                  email: _emailController.text,
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    phone: _subscriberNumberController.text)));
                          }
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

  Future<void> _submitForm() async {
    _subscriberNumberController.text =
        _subscriberNumberFormattedController.text.replaceAll(' ', '');
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }

    CustomNavigator.pushTo(context, AppPages.subscription);
  }
}