import 'package:bloggie/Models/NewsList.dart';
import 'package:bloggie/Screens/Discover.dart';
import 'package:bloggie/Screens/HomeScreen.dart';
import 'package:bloggie/Screens/ProfilePage.dart';
import 'package:bloggie/Screens/SavedPage.dart';
import 'package:bloggie/constants.dart';
import 'package:flutter/material.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({super.key});

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _seletedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _seletedTab,
        onTap: (value) {
          setState(() {
            _seletedTab = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 35,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.explore_outlined,
                size: 35,
              ),
              label: 'Discover'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.save,
                size: 35,
              ),
              label: 'Saved'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 35,
              ),
              label: 'Profile'),
        ],
      ),
      body: Stack(
        children: [
          renderview(
              0,
              const HomeScreen(
                newsItems: [],
              )),
          renderview(1, const DiscoverScreen()),
          renderview(2, const SavedScreen()),
          renderview(3, const ProfileScreen()),
        ],
      ),
    );
  }

  Widget renderview(int tabIndex, Widget view) {
    return IgnorePointer(
      ignoring: _seletedTab != tabIndex,
      child: Opacity(
        opacity: _seletedTab == tabIndex ? 1 : 0,
        child: view,
      ),
    );
  }
}
