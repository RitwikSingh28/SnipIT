import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/constants/value_constants.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/features/discover/data/models/discover_response_model.dart';
import 'package:snipit/features/discover/data/models/get_my_discovery_themes.dart';
import 'package:snipit/features/discover/presentation/bloc/discover/discovery_bloc.dart';
import 'package:snipit/features/discover/presentation/pages/discover_feed.dart';
import 'package:snipit/features/discover/presentation/pages/select_discovery.dart';
import 'package:snipit/features/feed/data/models/user_preference_model.dart';
import 'package:snipit/features/feed/presentation/widgets/header.dart';
import 'package:snipit/features/feed/presentation/widgets/news_tile_widget.dart';
import 'package:snipit/features/onboarding/data/model/userModel.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/ui/injection_container.dart';
import 'package:snipit/ui/molecules/custom_button.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_data.dart';
import '../../../../route/custom_navigator.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final _searchController = TextEditingController();

  final List<DiscoverTheme> _selectedItems = [];
  bool isCategoryConfirm = false;
  ScrollController controller = ScrollController();

  List<DiscoverThemeModel> _discoverOptions = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.addListener(() {
      // routeToPage(context);
      // print(controller.position.pixels);
      // if (controller.position.pixels > 350 &&
      //     controller.position.pixels < 550) {
      //   discoverTitle = "Discover Suggested";
      //   setState(() {});
      // } else if (controller.position.pixels > 550) {
      //   discoverTitle = "Discover Higest Rated";
      //   setState(() {});
      // } else if (controller.position.pixels < 350) {
      //   discoverTitle = "Discover";
      //   setState(() {});
      // }
    });
    super.initState();
  }

  // routeToPage(BuildContext context) async {
  //   var prefs = await UserHelpers.getMyPreferences();
  //   if (prefs != null && prefs != false) {
  //     if (prefs.discoverCategories.isNotEmpty) {
  //       return SelectDiscoverOptionsPage();
  //       // CustomNavigator.pushReplace(
  //       //     context, AppPages.selectDiscoveryOptionPage);
  //     } else {
  //       return DiscoveryFeedPage();
  //       // CustomNavigator.pushReplace(
  //       //     context, AppPages.selectDiscoveryOptionPage);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // UserPreferenceModel user= await  useUserHelpers.getMyPreferences();
    // if(user.)
    // return routeToPage(context);
    return Center(
      child: CircularProgressIndicator(),
    );
    //  FutureBuilder(
    //   future: UserHelpers.getMyPreferences(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       if (snapshot.hasError) {
    //         // Handle error
    //         return const Center(
    //           child: Text('Error loading preferences'),
    //         );
    //       } else if (snapshot.hasData) {
    //         if (snapshot.data.discoverCategories.isEmpty) {
    //           return const SelectDiscoverOptionsPage();
    //         } else {
    //           return DiscoveryFeedPage();
    //         }
    //       }
    //     }
    //     // Loading state
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
