import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/features/discover/data/models/get_my_discovery_themes.dart';

class DiscoverItemListTile extends StatefulWidget {
  final DiscoverTheme discoverTheme;
  final Function(bool)? onTap;
  final bool isSelected;
  const DiscoverItemListTile(
      {super.key,
      required this.discoverTheme,
      this.onTap,
      this.isSelected = false});

  @override
  State<DiscoverItemListTile> createState() => _DiscoverItemListTileState();
}

class _DiscoverItemListTileState extends State<DiscoverItemListTile> {
  bool _isSelected = false;
  @override
  void initState() {
    _isSelected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        if (widget.onTap != null) {
          widget.onTap!(_isSelected);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: _isSelected ? AppColors.primary : Color(0xFFEBE4D2),
                image: _isSelected
                    ? null
                    : DecorationImage(
                        image: NetworkImage(widget.discoverTheme.imageUrl),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {},
                      ),
              ),
              alignment: Alignment.center,
              child: _isSelected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 60,
                    )
                  : null,
            ),
          ),
          CustomSpacers.height8,
          Text(
            widget.discoverTheme.title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
              overflow: TextOverflow.ellipsis,
              fontFamily: AppFontFamily.maisonNeue,
            ),
          ),
        ],
      ),
    );
  }
}
