import 'dart:async';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/features/search_news/presentation/bloc/search_news_bloc.dart';
import 'package:snipit/features/search_news/presentation/bloc/search_news_event.dart';
import 'package:snipit/features/search_news/presentation/bloc/search_news_state.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/molecules/custom_scaffold.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../ui/injection_container.dart';
import '../../../feed/data/models/news_model.dart';
import '../../../feed/presentation/pages/myfeed_details_page.dart';

class SearchNewsPage extends StatefulWidget {
  const SearchNewsPage({Key? key}) : super(key: key);

  @override
  State<SearchNewsPage> createState() => _SearchNewsPageState();
}

class _SearchNewsPageState extends State<SearchNewsPage> {
  TextEditingController searchController = TextEditingController();
  final _focusNode = FocusNode();
  final _blocReference = sl<SearchNewsBloc>();
  List<News> news = [];
  final ScrollController _newsScrollController = ScrollController();
  StreamController<bool> _validationController = StreamController<bool>();
  bool isSearchQueryValid = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _validationController.close();
    searchController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.requestFocus();
    _blocReference.add(SearchNews(searchTerm: ""));
    _newsScrollController.addListener(() {
      if (_newsScrollController.offset ==
          _newsScrollController.position.maxScrollExtent) {
        _blocReference.add(SearchNews(searchTerm: searchController.text));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBarTitle: const Text("Search News"),
        body: BlocProvider(
          create: (context) => _blocReference,
          child: Column(
            children: [
              Container(
                height: 44.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color.fromARGB(255, 213, 213, 213),
                ),
                child: TextFormField(
                  cursorColor: AppColors.primary,
                  focusNode: _focusNode,
                  controller: searchController,
                  onChanged: (value) {
                    news = [];
                    _blocReference.add(RefreshEvent());
                    _blocReference.add(SearchNews(searchTerm: value));
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                      hintText: 'Search',
                      hintStyle: TextStyle(fontSize: 14),
                      suffixIcon: Icon(
                        Icons.search,
                        size: 18,
                      ),
                      suffixIconColor: AppColors.grey,
                      border: InputBorder.none),
                ),
              ),
              Expanded(child: _buildBody())
            ],
          ),
        ));
  }

  Widget _buildBody() {
    return BlocBuilder<SearchNewsBloc, SearchNewsState>(
        builder: (context, state) {
      if (state is SearchQueryInvalidState) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Type atleast 3 chars to activate search"),
        );
      }
      if (state is SearchNewsLoadingState) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        );
      }
      if (state is SearchNewsSuccessState) {
        news = news + state.news;
        if (news.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              "Oops..No results found.",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          );
        }
        return Column(
          children: [
            CustomSpacers.height10,
            Container(
              child: Row(
                children: [
                  Text(
                    "Search results for ",
                    style: AppTextStyles.textstyles_16_600
                        .copyWith(color: AppColors.lightGrey2),
                  ),
                  Text(
                    searchController.text.toString(),
                    style: AppTextStyles.textstyles_16_600,
                  )
                ],
              ),
            ),
            CustomSpacers.height30,
            Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.zero,
                  controller: _newsScrollController,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: news.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 0.4,
                    );
                  },
                  itemBuilder: (context, index) {
                    return NewsCard(
                      news: news[index],
                    );
                  }),
            ),
          ],
        );
      }
      return Container();
    });
  }

  Widget NewsCard({
    required News news,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyFeedDetailsPage(news: news)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Row(
          children: [
            Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: news.image,
                    errorWidget: (context, a, b) {
                      return Icon(
                        Icons.image,
                        color: AppColors.primary,
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                )),
            CustomSpacers.width10,
            Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      news.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.textstyles_16_600.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    CustomSpacers.height10,
                    Row(
                      children: [
                        Text(
                          formatDate(news.updatedAt),
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.lightGrey2,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 3,
                          backgroundColor: AppColors.lightGrey2,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          news.categoryId?.name ?? "",
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.lightGrey2,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                ))
          ],
        )),
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    // Format the date as "29th Dec, 2023"
    String day = DateFormat('d').format(dateTime);
    String month = DateFormat('MMM').format(dateTime);
    String year = DateFormat('y').format(dateTime);

    String ordinalSuffix = _getOrdinalSuffix(int.parse(day));

    return '$day$ordinalSuffix $month, $year';
  }

  String _getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
