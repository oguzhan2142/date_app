import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/chat/view/chat_view.dart';
import 'package:frontend/features/match/view/match_view.dart';
import 'package:frontend/features/profile/view/profile_view.dart';
import 'package:frontend/gen/assets.gen.dart';

import '../../../manager/theme/colors.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int _selectedIndex = 0;
  final icons = [
    Assets.icons.conversation.path,
    Assets.icons.user.path,
    Assets.icons.fire.path,
  ];

  Image _item(int tabIndex, bool isSelected) {
    return Image.asset(
      icons[tabIndex],
      color: isSelected ? Colors.white : Colors.black,
    );
  }

  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  Widget _icon(String asset, bool isActive) {
    return Image.asset(
      asset,
      color: isActive ? primary : gray,
      height: 24,
    );
  }

  bool _isActiveIndex(int index) => _selectedIndex == index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            children: const <Widget>[
              MatchView(),
              SizedBox(),
              ChatView(),
              ProfileView(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _selectedIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            _pageController.jumpToPage(index);
          }),
          items: [
            BottomNavyBarItem(
              icon: _icon(
                Assets.icons.fire.path,
                _isActiveIndex(0),
              ),
              title: const Text('Eşleşme'),
              activeColor: primary,
              inactiveColor: gray,
            ),
            BottomNavyBarItem(
              icon: _icon(
                Assets.icons.users.path,
                _isActiveIndex(1),
              ),
              title: const Text('Beğenenler'),
              activeColor: primary,
              inactiveColor: gray,
            ),
            BottomNavyBarItem(
              icon: _icon(
                Assets.icons.chat.path,
                _isActiveIndex(2),
              ),
              title: const Text('Mesajlar'),
              activeColor: primary,
              inactiveColor: gray,
            ),
            BottomNavyBarItem(
              icon: _icon(
                Assets.icons.user.path,
                _isActiveIndex(3),
              ),
              title: const Text('Profil'),
              activeColor: primary,
              inactiveColor: gray,
            ),
          ],
        ));
  }
}
