import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:frontend/features/chat/view/chat_view.dart';
import 'package:frontend/features/match/view/match_view.dart';
import 'package:frontend/features/profile/view/profile_view.dart';
import 'package:frontend/gen/assets.gen.dart';
import 'package:provider/provider.dart';

import '../../match/viewmodel/match_viewmodel.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int index = 0;
  final icons = [
    Assets.icons.conversation.path,
    Assets.icons.user.path,
    Assets.icons.fire.path,
  ];

  final pages = <Widget>[
    const ChatView(),
    const ProfileView(),
    const MatchView(),
  ];

  Image _item(int tabIndex, bool isSelected) {
    return Image.asset(
      icons[tabIndex],
      color: isSelected ? Colors.white : Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      floatingActionButton: pages.length - 1 == index
          ? null
          : FloatingActionButton(
              onPressed: () {
                setState(() => index = pages.length - 1);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _item(pages.length - 1, pages.length - 1 == index),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        backgroundColor: Theme.of(context).primaryColor,

        activeIndex: index,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 48,
        rightCornerRadius: 48,
        onTap: (index) {
          setState(() => this.index = index);
        },
        itemCount: pages.length - 1,

        tabBuilder: (int index, bool isActive) {
          return IconButton(
            onPressed: () {
              setState(() => this.index = index);
            },
            icon: Padding(
              padding: const EdgeInsets.all(4.0),
              child: _item(index, isActive),
            ),
          );
        },
        //other params
      ),
    );
  }
}
