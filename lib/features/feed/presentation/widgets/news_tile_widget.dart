import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_images.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/core/utils/screen_utils.dart';
import 'package:snipit/features/feed/data/models/get_news_by_category_model.dart';
import 'package:snipit/features/feed/data/models/news_model.dart';
import 'package:snipit/features/feed/presentation/pages/myfeed_details_page.dart';
import 'package:snipit/features/feed/presentation/widgets/custom_popup_menu_button.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/molecules/custom_button.dart';

class NewsTileWidget extends StatefulWidget {
  final News news;
  final Function(bool)? onLikeTap;
  const NewsTileWidget({super.key, required this.news, this.onLikeTap});

  @override
  State<NewsTileWidget> createState() => _NewsTileWidgetState();
}

class _NewsTileWidgetState extends State<NewsTileWidget> {
  late bool isLiked = false;
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    init(widget.news.liked);
  }

  init(bool value) {
    setState(() {
      isLiked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 322.h,
        width: 284.w,
        decoration: BoxDecoration(
            color: Colors.grey,
            // color: Colors.yellow,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(widget.news.image), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                      color: isLiked ? AppColors.red : AppColors.Secondary,
                      size: 20,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.news.categoryId?.name.toUpperCase()??"",
                      style: AppTextStyles.textStyles_MN_30_600_black.copyWith(
                        fontSize: 12,
                        shadows: [Shadow(blurRadius: 1.5, color: Colors.grey)],
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  CustomPopupMenuButton(
                    iconColor: AppColors.Secondary,
                    news: widget.news,
                  ),
                ],
              ),
              Spacer(),
              Text(
                widget.news.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: AppTextStyles.textStyles_MN_30_600_black.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  shadows: [Shadow(blurRadius: 1.5, color: Colors.grey)],
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CustomSpacers.height10,
              CustomButton(
                strButtonText: 'Read Article',
                buttonAction: () {
                  // CustomNavigator.pushTo(context, AppPages.myFeedDetails,
                  //     arguments: {'news': widget.news});
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyFeedDetailsPage(news: widget.news,
                    );
                  }));
                },
                dHeight: 35.h,
                textColor: AppColors.black,
                textStyle: AppTextStyles.textStyles_MN_30_600_black.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
