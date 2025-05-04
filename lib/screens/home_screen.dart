import 'package:flutter/material.dart';
import 'package:my_boot_ai/screens/chat_screen.dart';
import 'package:my_boot_ai/screens/history_screen.dart';
import 'package:my_boot_ai/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({required this.title, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  final List<Widget> screens = [
    ChatScreen(title: 'Chat Screen'),
    HistoryScreen(title: 'Chat History Screen'),
    ProfileScreen(title: 'Profile Screen'),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: screens,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            pageController.jumpToPage(index);
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
              ),
              label: 'chat'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
              ),
              label: 'history'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'profile'),
        ],
      ),
    );
  }
}
