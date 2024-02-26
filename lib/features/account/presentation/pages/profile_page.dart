import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_icons.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/helpers/scaffold_helpers.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/core/validators.dart';
import 'package:snipit/features/account/domain/entities/update_username_entity.dart';
import 'package:snipit/features/account/presentation/bloc/update_user_name_event.dart';
import 'package:snipit/features/account/presentation/bloc/update_user_name_state.dart';
import 'package:snipit/features/feed/data/models/user_preference_model.dart';
import 'package:snipit/features/onboarding/data/model/userModel.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/molecules/custom_button.dart';
import 'package:snipit/ui/molecules/custom_scaffold.dart';
import 'package:snipit/ui/molecules/custom_text_field.dart';

import '../../../../ui/injection_container.dart';
import '../bloc/update_user_name_bloc.dart';
import '../widgets/update_username_bottomsheet.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  String userName = '';

  _openPersonalizeContent() async {
    try {
      var preferences = await UserHelpers.getMyPreferences();
      if (preferences != false) {
        CustomNavigator.pushTo(context, AppPages.category, arguments: {
          "selectedCategories": preferences.categories,
          "previouslySelectedSubCategories": preferences.subcategories
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUserName();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackgroundImage: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProfileInfo(),
            CustomSpacers.height32,
            _buildLinksSection(
              title: 'Personal info',
              items: [
                ActionLinkItem(
                  iconPath: AppIcons.bag,
                  title: 'My subscription',
                  onTap: () =>
                      CustomNavigator.pushTo(context, AppPages.subscription),
                ),
                ActionLinkItem(
                  iconPath: AppIcons.location,
                  title: 'My address',
                  onTap: () {},
                ),
                ActionLinkItem(
                    iconPath: AppIcons.person,
                    title: 'Update Username',
                    onTap: () {
                      final _bloc = sl<UpdateUserNameBloc>();
                      ScaffoldHelpers.showBottomSheet(
                              context: context,
                              child: const UpdateUserNameBottomSheet())
                          .then((value) {
                        setUserName();
                      });
                    }),
              ],
            ),
            CustomSpacers.height16,
            _buildLinksSection(
              title: 'Security',
              items: [
                ActionLinkItem(
                  iconPath: AppIcons.lock,
                  title: 'Change password',
                  onTap: () {},
                ),
                ActionLinkItem(
                  iconPath: AppIcons.unlock,
                  title: 'Forgot password',
                  onTap: () {
                    CustomNavigator.pushTo(context, AppPages.forgotPAssword,
                        arguments: {"fromLogin": false});
                  },
                ),
                ActionLinkItem(
                  iconPath: AppIcons.shield,
                  title: 'Security',
                  onTap: () {},
                ),
              ],
            ),
            CustomSpacers.height16,
            _buildLinksSection(
              title: 'General',
              items: [
                ActionLinkItem(
                  iconPath: AppIcons.globe,
                  title: 'Language',
                  onTap: () {},
                ),
                ActionLinkItem(
                    iconPath: AppIcons.activity,
                    title: 'Personalise content',
                    onTap: _openPersonalizeContent),
                ActionLinkItem(
                  iconPath: AppIcons.activity,
                  title: 'Logout',
                  onTap: () {
                    UserHelpers.logout();
                    CustomNavigator.pushReplace(
                      kNavigatorKey.currentContext!,
                      AppPages.appEntry,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Row(
      children: [
        CircleAvatar(
          minRadius: 30.w,
          maxRadius: 30.w,
          backgroundImage: UserHelpers.userDetails!.photo != null
              ? NetworkImage(
                  UserHelpers.userDetails!.photo!,
                )
              : NetworkImage(
                  "",
                ),
          onBackgroundImageError: (exception, stackTrace) {},
        ),
        CustomSpacers.width12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                UserHelpers.userDetails?.firstName == ''
                    ? 'Hello There!'
                    : '${UserHelpers.userDetails?.firstName} ${UserHelpers.userDetails?.lastName}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.tertiaryText,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: AppFontFamily.maisonNeue,
                ),
              ),
              Text(
                userName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6C6C6C),
                  overflow: TextOverflow.ellipsis,
                  fontFamily: AppFontFamily.maisonNeue,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            CustomNavigator.pushTo(context, AppPages.updateProfile);
          },
          child: SvgPicture.asset(
            AppIcons.editSquare,
            color: AppColors.tertiaryText,
            width: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildLinksSection({
    required String title,
    required List<ActionLinkItem> items,
  }) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.tertiaryText,
              overflow: TextOverflow.ellipsis,
              fontFamily: AppFontFamily.maisonNeue,
            ),
          ),
          CustomSpacers.height2,
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: items.length,
            itemBuilder: (context, index) => _buildLinkItem(items[index]),
          ),
        ],
      );

  Widget _buildLinkItem(ActionLinkItem item) => InkWell(
        onTap: item.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                child: SvgPicture.asset(
                  item.iconPath,
                  color: AppColors.tertiaryText,
                ),
              ),
              CustomSpacers.width12,
              Expanded(
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.tertiaryText,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: AppFontFamily.maisonNeue,
                  ),
                ),
              ),
              CustomSpacers.width12,
              Icon(
                Icons.chevron_right_rounded,
                size: 24,
                color: Color(0xFF6C6C6C),
              ),
            ],
          ),
        ),
      );

  setUserName() async {
    var user = await UserHelpers.getUserDetails();
    setState(() {
      userName = user.userName;
    });
  }
}

class ActionLinkItem {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const ActionLinkItem({
    required this.iconPath,
    required this.title,
    required this.onTap,
  });
}
