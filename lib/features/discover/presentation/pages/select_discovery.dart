import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/features/discover/data/models/discover_response_model.dart';
import 'package:snipit/features/discover/data/models/get_my_discovery_themes.dart';
import 'package:snipit/features/discover/presentation/bloc/discover/discovery_bloc.dart';
import 'package:snipit/features/discover/presentation/widgets/discover_item_listtile.dart';
import 'package:snipit/features/feed/data/models/user_preference_response.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/injection_container.dart';

class SelectDiscoverOptionsPage extends StatefulWidget {
  final Function(PreferenceResponseModel) onDiscoverSelected;
  const SelectDiscoverOptionsPage(
      {super.key, required this.onDiscoverSelected});

  @override
  State<SelectDiscoverOptionsPage> createState() =>
      _SelectDiscoverOptionsPageState();
}

class _SelectDiscoverOptionsPageState extends State<SelectDiscoverOptionsPage>
    with AutomaticKeepAliveClientMixin {
  final List<DiscoverTheme> _selectedItems = [];
  List<DiscoverThemeModel> _availableDiscoverOptions = [];
  final _blocReference = sl<DiscoveryBloc>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _blocReference.add(GetDiscoverOptionsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          _blocReference.add(UpdateDiscoverOptionsEvent(
              discoverIds: _selectedItems.map((e) => e.id).toList()));
        },
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
            color: AppColors.primary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                size: 20,
                color: AppColors.white,
              ),
              CustomSpacers.width10,
              Text(
                "Confirm",
                style: AppTextStyles.buttonTextStyle,
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
          title: Text(
        "Select Discover options",
        style: AppTextStyles.subTextStyle16_500.copyWith(fontSize: 20),
      )),
      body: BlocProvider(
        create: (context) => _blocReference,
        child: BlocListener<DiscoveryBloc, DiscoveryState>(
          listener: (context, state) {
            if (state is DiscoverOptionsLoadedState) {
              _availableDiscoverOptions = state.discoveries;
            }
            if (state is DiscoverOptionUpdatedState) {
              // CustomNavigator.pop(context);
              widget.onDiscoverSelected(state.response);
            }
          },
          child: BlocBuilder<DiscoveryBloc, DiscoveryState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                        _availableDiscoverOptions.length,
                        (index) => _buildDiscoverGridSection(
                            title: _availableDiscoverOptions[index]
                                .subCategoryName,
                            subtitle:
                                "Select the items you’d like to see more of:",
                            items: _availableDiscoverOptions[index]
                                .discoverTheme)),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDiscoverGridSection({
    required String title,
    required String subtitle,
    required List<DiscoverTheme> items,
  }) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              overflow: TextOverflow.ellipsis,
              fontFamily: AppFontFamily.maisonNeue,
            ),
          ),
          CustomSpacers.height8,
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: AppColors.black,
              fontFamily: AppFontFamily.maisonNeue,
            ),
          ),
          CustomSpacers.height20,
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 110,
                mainAxisSpacing: 20,
                crossAxisSpacing: 8,
                childAspectRatio: 1.0,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) => DiscoverItemListTile(
                    discoverTheme: items[index],
                    onTap: (isSelected) {
                      if (isSelected) {
                        _selectedItems.add(items[index]);
                      } else {
                        _selectedItems.remove(items[index]);
                      }
                    },
                    isSelected: _selectedItems.contains(
                      items[index],
                    ),
                  )),
          CustomSpacers.height30,
        ],
      );

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
