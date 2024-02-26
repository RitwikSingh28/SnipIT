import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_images.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/feed/data/models/news_model.dart';
import 'package:snipit/route/custom_navigator.dart';

import '../widgets/custom_popup_menu_button.dart';

class MyFeedDetailsPage extends StatefulWidget {
  final News news;
  final Function(bool)? onLikeTap;
  const MyFeedDetailsPage({super.key, required this.news, this.onLikeTap});

  @override
  State<MyFeedDetailsPage> createState() => _MyFeedDetailsPageState();
}

class _MyFeedDetailsPageState extends State<MyFeedDetailsPage> {
  late bool isLiked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init(widget.news.liked);
  }

  init(bool value) {
    setState(() {
      isLiked = value;
    });
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
          leading: GestureDetector(
              onTap: () {
                CustomNavigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.black,
              )),
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                if (widget.onLikeTap != null) {
                  widget.onLikeTap!(isLiked);
                }
                setState(() {
                  isLiked = !isLiked;
                });
              },
              child: Icon(
                Icons.favorite,
                color: isLiked ? AppColors.red : AppColors.white,
                size: 20,
              ),
            ),
            SizedBox(width: 20),
            CustomPopupMenuButton(
              iconColor: AppColors.black,
              news: widget.news,
            ),
            SizedBox(width: 15),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  _buildHeader() => Hero(
        tag: widget.news.id,
        child: Container(
          height: 248.h,
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            widget.news.image,
            fit: BoxFit.cover,
          ),
        ),
      );

  _buildBody() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSpacers.height20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.news.newsMeta?.postedTime != null)
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color.fromARGB(255, 166, 166, 166))),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Center(
                          child: Text(
                              DateFormat("dd-MM-yyy")
                                  .format(widget.news.newsMeta!.postedTime!),
                              style: AppTextStyles.textStyles_MN_30_600_black
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700))),
                    ),
                  ),
                Container(
                  height: 34.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.news.categoryId?.name??"",
                      style: AppTextStyles.textStyles_MN_30_600_black
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  )),
                ),
              ],
            ),
            CustomSpacers.height4,
            if (widget.news.newsMeta != null)
              Row(
                children: [
                  Text("Source: ",
                      style: AppTextStyles.textStyles_MN_30_600_black
                          .copyWith(fontSize: 12)),
                  Text(widget.news.newsMeta?.newsSource ?? "",
                      style: AppTextStyles.textStyles_MN_30_600_black
                          .copyWith(fontSize: 14))
                ],
              ),
            CustomSpacers.height20,
            Text(
              '${widget.news.title}',
              style: AppTextStyles.textStyles_MN_30_600_black
                  .copyWith(fontSize: 27, fontWeight: FontWeight.w700),
            ),
            CustomSpacers.height20,
            Text(
              '${widget.news.body}',
              style: AppTextStyles.textStyles_MN_30_600_black
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            CustomSpacers.height20,
          ],
        ),
      );
}
