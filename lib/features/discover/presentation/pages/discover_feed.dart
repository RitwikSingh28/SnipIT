import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_data.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/constants/value_constants.dart';
import 'package:snipit/core/helpers/ui_helpers.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/features/discover/data/models/get_my_discovery_themes.dart';
import 'package:snipit/features/discover/presentation/bloc/discover/discovery_bloc.dart';
import 'package:snipit/features/discover/presentation/bloc/discoverFeed/discover_feed_bloc.dart';
import 'package:snipit/features/feed/data/models/news_model.dart';
import 'package:snipit/features/feed/data/models/user_preference_model.dart';
import 'package:snipit/features/feed/presentation/widgets/header.dart';
import 'package:snipit/features/feed/presentation/widgets/news_tile_widget.dart';
import 'package:snipit/features/onboarding/data/model/discoverModel.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/injection_container.dart';

class DiscoveryFeedPage extends StatefulWidget {
  const DiscoveryFeedPage({super.key});

  @override
  State<DiscoveryFeedPage> createState() => _DiscoveryFeedPageState();
}

class _DiscoveryFeedPageState extends State<DiscoveryFeedPage>
    with AutomaticKeepAliveClientMixin {
  final _searchController = TextEditingController();
  int _tabBarSelectedIndex = 0;
  ScrollController _controller = ScrollController();
  StreamController<String> _discoverTitleController = StreamController<String>()
    ..add("Discover");

  List<News> news = [];
  final _blocReference = sl<DiscoverFeedBloc>();
  List<DiscoverCategoryModel> preferences = [
    DiscoverCategoryModel(id: "0", title: "Top Stories", image: "")
  ];
  @override
  void initState() {
    setPreferences();
    _controller.addListener(() {
      if (_controller.position.pixels > 350 &&
          _controller.position.pixels < 550) {
        _discoverTitleController.add("Discover Suggested");
      } else if (_controller.position.pixels > 550) {
        _discoverTitleController.add("Discover Higest Rated");
      } else if (_controller.position.pixels < 350) {
        _discoverTitleController.add("Discover ");
      }
    });
    super.initState();
  }

  setPreferences() async {
    var userPreferences = await UserHelpers.getMyPreferences();
    preferences.addAll(userPreferences.discoverCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Secondary,
      appBar: AppBar(
          backgroundColor: AppColors.Secondary,
          // title: Text(discoverTitle, style: AppTextStyles.subTextStyle16_500),
          // leading: GestureDetector(
          //     onTap: () {
          //       CustomNavigator.pop(context);
          //     },
          //     child: const Icon(
          //       Icons.arrow_back,
          //       color: AppColors.black,
          //     )),
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 7.0),
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: AppColors.primary,
                    ),
                  )
                ],
              ),
            ),
          ]),
      body: BlocProvider(
        create: (context) => _blocReference..add(GetDiscoverNewsEvent()),
        child: BlocListener<DiscoverFeedBloc, DiscoverFeedState>(
          listener: (context, state) {
            if (state is DiscoverNewsLoadedState) {
              news = state.response.news;
            }
          },
          child: BlocBuilder<DiscoverFeedBloc, DiscoverFeedState>(
            builder: (context, state) {
              return Column(
                children: [
                  StreamBuilder<String>(
                      stream: _discoverTitleController.stream,
                      builder: (context, snapshot) {
                        return Header(
                          title: snapshot.data ?? "Discover",
                          actionText: 'See all',
                          actionCallback: () {},
                          searchController: _searchController,
                          tabBarItems: preferences.map((e) => e.title).toList(),
                          onTabBarItemTap: (index) {
                            // setState(() {
                            //   // _tabBarSelectedIndex = index;
                            // });
                          },
                          tabBarSelectedIndex: _tabBarSelectedIndex,
                        );
                      }),
                  Flexible(
                    child: SingleChildScrollView(
                      controller: _controller,
                      child: Stack(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.all(VALUE_STANDARD_SCREEN_PADDING),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildBody()
                                // Stack(
                                //     children: [
                                //       Column(
                                //           children: List.generate(
                                //         _discoverOptions.length,
                                //         (index) => Padding(
                                //           padding: const EdgeInsets.only(
                                //               top: 12.0),
                                //           child: _buildDiscoverGridSection(
                                //             title: _discoverOptions[index]
                                //                 .subCategoryName,
                                //             subtitle:
                                //                 'Select the items you\'d like to see more of:',
                                //             items: _discoverOptions[index]
                                //                 .discoverTheme,
                                //           ),
                                //         ),
                                //       )),
                                //     ],
                                //   ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _buildBody() => Column(
        children: [
          SizedBox(
            height: 322.h,
            width: 872.w,
            child: ListView.builder(
                itemCount: news.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return NewsTileWidget(
                    news: news[index],
                    onLikeTap: (a) {},
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Suggested',
                    style: AppTextStyles.textStyles_MN_30_400_black.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                Text(
                  'See All',
                  style: AppTextStyles.textStyles_MN_30_400_black.copyWith(
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 322.h,
            width: 872.w,
            child: ListView.builder(
                itemCount: news.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return NewsTileWidget(
                    news: news[index],
                    onLikeTap: (a) {},
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Higest Rated',
                    style: AppTextStyles.textStyles_MN_30_400_black.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                Text(
                  'See All',
                  style: AppTextStyles.textStyles_MN_30_400_black.copyWith(
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 322.h,
            width: 872.w,
            child: ListView.builder(
                itemCount: news.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return NewsTileWidget(
                    news: news[index],
                    onLikeTap: (a) {},
                  );
                }),
          ),
        ],
      );

  // @override
  // void updateKeepAlive() {
  //   // TODO: implement updateKeepAlive
  // }

  @override
  bool get wantKeepAlive => false;
}
