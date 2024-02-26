import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_data.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/feed/data/models/news_model.dart';
import 'package:snipit/features/feed/data/models/user_preference_model.dart';
import 'package:snipit/features/feed/domain/entity/get_newsby_category_entity.dart';
import 'package:snipit/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:snipit/features/feed/presentation/widgets/news_tile_shimmer.dart';
import 'package:snipit/features/feed/presentation/widgets/news_tile_widget.dart';
import 'package:snipit/features/onboarding/data/model/category_model.dart';
import 'package:snipit/features/onboarding/domain/entities/like_newsby_id_entity.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/injection_container.dart';
import 'package:snipit/ui/molecules/custom_divider.dart';
import 'package:snipit/ui/molecules/custom_text_field.dart';

import '../widgets/header.dart';

class MyFeedPage extends StatefulWidget {
  const MyFeedPage({super.key});

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _searchController = TextEditingController();
  bool _isCategoryLoading = true;
  int _selectedIndex = 0;
  final _blocReference = sl<FeedBloc>();
  List<News> news = [];
  bool isNewsLoading = true;
  UserPreferenceModel? userPreferences;
  List<CategoryModel> preferences = [
    CategoryModel(id: "0", image: "", name: "Top Stories")
  ];

  final ScrollController _myNewsScrollController = ScrollController();
  final ScrollController _suggestedNewsScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _blocReference.add(GetPreferencesEvent());
    });

    _myNewsScrollController.addListener(() {
      if (_myNewsScrollController.offset ==
          _myNewsScrollController.position.maxScrollExtent) {
        getNews();
      }
    });

    _suggestedNewsScrollController.addListener(() {
      if (_suggestedNewsScrollController.offset ==
          _suggestedNewsScrollController.position.maxScrollExtent) {
        getNews();
      }
    });
  }

  @override
  void dispose() {
    _blocReference.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.Secondary,
        appBar: AppBar(
            backgroundColor: AppColors.Secondary,
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
        body: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => _blocReference,
            child: BlocListener<FeedBloc, FeedState>(
              listener: (context, state) {
                if (state is PreferencesLoadedState) {
                  _isCategoryLoading = false;
                  userPreferences = state.userPreferenceModel;
                  preferences.addAll(state.userPreferenceModel.categories);
                  _blocReference.add(GetMyNewsEvent());
                }
                if (state is ChangeNewsTabSuccessState) {
                  _selectedIndex = state.index;
                  news = [];
                  // +1 to index because Top categories are always going to take the 0th Index
                  if (_selectedIndex != 0) {
                    _blocReference.add(GetNewsByCategoryEvent(category: preferences[_selectedIndex].id));
                  } else {
                    _blocReference.add(GetMyNewsEvent());
                  }
                }
                if (state is GetNewsSuccessState) {
                  news = news+state.news;
                  isNewsLoading = false;
                }
                if (state is LikeNewsSuccessState) {
                  // Update the copy of the news locally
                  // news[state.newsIndex].liked = !news[state.newsIndex].liked;
                  final likedNews =
                      news.firstWhere((elt) => elt.id == state.newsId);
                  likedNews.liked = !likedNews.liked;
                }
              },
              child: BlocBuilder<FeedBloc, FeedState>(
                bloc: _blocReference,
                builder: (context, state) {
                  return Column(children: [
                    Header(
                      // scrollController: ScrollController(),
                      title: 'My Feed',
                      searchController: _searchController,
                      tabBarItems: preferences != null
                          ? preferences.map((e) => e.name).toList()
                          : [],
                      onTabBarItemTap: (index) {
                        _blocReference
                            .add(ChangeCategoryTabEvent(index: index));
                      },
                      tabBarSelectedIndex: _selectedIndex,
                    ),
                    _buildBody(),
                  ]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildBody() => isNewsLoading
      ? Column(
          children: [
            const NewsShimmer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
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
            const NewsShimmer(),
          ],
        )
      : news.isEmpty
          ? Center(
              child: Text('No News available.'),
            )
          : Column(
              children: [
                SizedBox(
                  height: 322.h,
                  width: 872.w,
                  child: ListView.builder(
                    controller: _myNewsScrollController,
                      itemCount: news.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return BlocBuilder<FeedBloc, FeedState>(
                          builder: (context, state) {
                            return NewsTileWidget(
                              news: news[index],
                              onLikeTap: (isLiked) {
                                _blocReference.add(LikeNewsEvent(
                                    newsIndex: index,
                                    entity: LikeNewsByIdEntity(
                                        newsId: news[index].id)));
                              },
                            );
                          },
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Suggested',
                          style:
                              AppTextStyles.textStyles_MN_30_400_black.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      Text(
                        'See All',
                        style:
                            AppTextStyles.textStyles_MN_30_400_black.copyWith(
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
                    controller: _suggestedNewsScrollController,
                      itemCount: news.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return BlocBuilder<FeedBloc, FeedState>(
                          builder: (context, state) {
                            return NewsTileWidget(
                              news: news[index],
                              onLikeTap: (isLiked) {
                                _blocReference.add(LikeNewsEvent(
                                    newsIndex: index,
                                    entity: LikeNewsByIdEntity(
                                        newsId: news[index].id)));
                              },
                            );
                          },
                        );
                      }),
                ),
              ],
            );

  @override
  bool get wantKeepAlive => false;

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade300,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 322.h,
        width: 284.w,
      ),
    );
  }

  getNews() {
    if(_selectedIndex!=0){

    }
    else{
      _blocReference.add(GetMyNewsEvent());
    }
  }
}

class NewsCategoryHeadlineWidget extends StatefulWidget {
  int selectedIndex;
  String title;
  int index;
  final bool isSelected;
  Function(int) ontap;
  NewsCategoryHeadlineWidget(
      {super.key,
      required this.selectedIndex,
      required this.title,
      required this.index,
      this.isSelected = false,
      required this.ontap});

  @override
  State<NewsCategoryHeadlineWidget> createState() =>
      _NewsCategoryHeadlineWidgetState();
}

class _NewsCategoryHeadlineWidgetState
    extends State<NewsCategoryHeadlineWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.index);
        widget.ontap(widget.index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
            height: 40.h,
            // width: 100.w,
            // color: Colors.yellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.title,
                        textAlign: TextAlign.center,
                        style:
                            AppTextStyles.textStyles_MN_30_600_black.copyWith(
                          fontWeight: widget.isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black
                              .withOpacity(!widget.isSelected ? 0.5 : 1),
                        )),
                    CustomSpacers.width6,
                    widget.isSelected
                        ? const Padding(
                            padding: EdgeInsets.only(bottom: 7.0),
                            child: CircleAvatar(
                              radius: 3.5,
                              backgroundColor: AppColors.primary,
                            ),
                          )
                        : Container(),
                  ],
                ),
                widget.selectedIndex == widget.index
                    ? Container(
                        height: 2,
                        color: AppColors.primary,
                      )
                    : Container(),
              ],
            )),
      ),
    );
  }
}
