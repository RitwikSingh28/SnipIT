import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snipit/features/feed/domain/entity/interaction_entity.dart';
import 'package:snipit/features/feed/presentation/bloc/feed_detail_bloc/feed_details_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../ui/injection_container.dart';
import '../../data/models/news_model.dart';
import '../bloc/feed_detail_bloc/feed_detail_event.dart';

class CustomPopupMenuButton extends StatefulWidget {
  final Color iconColor;
  final News news;
  const CustomPopupMenuButton({super.key, required this.iconColor,required this.news});

  @override
  State<CustomPopupMenuButton> createState() => _CustomPopupMenuButtonState();
}

class _CustomPopupMenuButtonState extends State<CustomPopupMenuButton> {

  final _bloc=sl<FeedDetailBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>_bloc,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerTheme: DividerThemeData(
            color: Color(0x66262626),
            thickness: 0,
            space: 0,
            indent: 20,
            endIndent: 20,
          ),
        ),
        child: PopupMenuButton(
          itemBuilder: (context) => [
            _buildPopupMenuItem(
              title: 'Like',
              trailingIcon: Icons.favorite,
              onTap: () {},
            ),
            _buildPopupMenuDivider(),
            _buildPopupMenuItem(
              title: 'Show less like this',
              trailingIcon: Icons.thumb_down,
              onTap: (){
                addInteractionEvent(interactionType: InteractionType.SeeLess,newsId: widget.news.id);
              },
              isLocked: true,
            ),
            _buildPopupMenuDivider(),
            _buildPopupMenuItem(
              title: 'Show more like this',
              trailingIcon: Icons.thumb_up,
              onTap: (){
                addInteractionEvent(interactionType: InteractionType.SeeMore,newsId: widget.news.id);
              },
              isLocked: true,
            ),
            _buildPopupMenuDivider(),
            _buildPopupMenuItem(
              title: 'Mute',
              trailingIcon: CupertinoIcons.speaker_fill,
              onTap: (){
                addInteractionEvent(interactionType: InteractionType.Mute,newsId: widget.news.id);
              },
              isLocked: true,
            ),
            _buildPopupMenuDivider(),
            _buildPopupMenuItem(
              title: 'Share',
              trailingIcon: Icons.share,
              onTap: () {},
            ),
            _buildPopupMenuDivider(),
            _buildPopupMenuItem(
              title: 'Report',
              trailingIcon: Icons.report_problem,
              onTap: () {
                addInteractionEvent(interactionType: InteractionType.Report,newsId: widget.news.id);
              },
            ),
          ],
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          position: PopupMenuPosition.under,
          tooltip: '',
          child: Icon(
            Icons.more_horiz_rounded,
            color: widget.iconColor,
            size: 34,
          ),
        ),
      ),
    );
  }

  PopupMenuEntry _buildPopupMenuItem({
    required String title,
    required IconData trailingIcon,
    VoidCallback? onTap,
    bool isLocked = false,
  }) =>
      PopupMenuItem(
        onTap: onTap,
        padding: EdgeInsets.symmetric(
          horizontal: 20
        ),
        child: Row(
          children: [
            if (isLocked)
              Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.lock,
                    color: Color(0xFF262626),
                    size: 16,
                  )),
            Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isLocked ? Color(0x66262626) : AppColors.black,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: AppFontFamily.maisonNeue,
                  ),
                )),
            SizedBox(width: 12),
            Icon(
              trailingIcon,
              color: Color(0x66262626),
              size: 16,
            ),
          ],
        ),
      );

  PopupMenuEntry _buildPopupMenuDivider() => PopupMenuDivider(height: 0);

  addInteractionEvent({required InteractionType interactionType,required String newsId}) {
    _bloc.add(AddInteractionEvent(entity: InteractionEntity(interactionType: interactionType,newsIDEntity: NewsIDEntity(newsID: newsId))));
  }
}
