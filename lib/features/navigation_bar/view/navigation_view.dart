import 'package:flutter/material.dart';
import 'package:frontend/features/chat/view/chat_view.dart';
import 'package:frontend/features/match/view/match_view.dart';
import 'package:frontend/features/profile/view/profile_view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int index = 0;
  final pages = [
    const ChatView(),
    const MatchView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() => index = value);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'like',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'account',
          )
        ],
      ),
    );
  }
}
