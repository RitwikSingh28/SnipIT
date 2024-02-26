import 'package:flutter/material.dart';
import 'package:snipit/core/helpers/user_helpers.dart';
import 'package:snipit/features/account/presentation/pages/profile_page.dart';
import 'package:snipit/features/discover/presentation/pages/discover_feed.dart';
import 'package:snipit/features/discover/presentation/pages/select_discovery.dart';
import 'package:snipit/features/feed/presentation/pages/myfeed_page.dart';
import '../../../../ui/molecules/custom_bottom_navigation_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _preferencesSelected = false;
  @override
  void initState() {
    super.initState();
    routeToPage(context);
  }

  routeToPage(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 200));
    var prefs = await UserHelpers.getMyPreferences();
    if (prefs != null && prefs != false) {
      if (prefs.discoverCategories.isNotEmpty) {
        _preferencesSelected = true;
      } else {
        _preferencesSelected = false;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          MyFeedPage(),
          _preferencesSelected
              ? DiscoveryFeedPage()
              : SelectDiscoverOptionsPage(
                  onDiscoverSelected: (p) {
                    setState(() {
                      _preferencesSelected = true;
                    });
                  },
                ),
          ProfilePage(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
