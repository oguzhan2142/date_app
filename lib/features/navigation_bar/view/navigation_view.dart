import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/chat/view/chat_view.dart';
import 'package:frontend/features/match/view/match_view.dart';
import 'package:frontend/features/navigation_bar/provider/navigation_state_provider.dart';
import 'package:frontend/features/profile/view/profile_view.dart';
import 'package:frontend/gen/assets.gen.dart';

class NavigationView extends ConsumerStatefulWidget {
  const NavigationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavigationViewState();
}

class _NavigationViewState extends ConsumerState<NavigationView> {
  final icons = [
    Assets.icons.user.path,
    Assets.icons.conversation.path,
    Assets.icons.fire.path,
  ];

  final pages = [
    const ProfileView(),
    const ChatView(),
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
    int index = ref.watch(navBarIndexProvider);
    return Scaffold(
      body: pages[index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(navBarIndexProvider.state).state = pages.length - 1;
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
          print(index);
          ref.read(navBarIndexProvider.state).state = index;
        },
        itemCount: pages.length - 1,

        tabBuilder: (int index, bool isActive) {
          return IconButton(
            onPressed: () {
              ref.read(navBarIndexProvider.state).state = index;
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
