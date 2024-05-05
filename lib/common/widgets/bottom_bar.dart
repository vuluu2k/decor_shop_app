import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/global_variables.dart';
import 'package:shop/features/account/screens/account_screen.dart';
import 'package:shop/features/favorite/screens/favorite_screen.dart';
import 'package:shop/features/home/screens/home_screen.dart';
import 'package:shop/providers/favorite_provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const AccountScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoriteProvider>(context).favorites;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: Colors.white,
        iconSize: 28,
        onTap: updatePage,
        showUnselectedLabels: true,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        items: [
          BottomNavigationBarItem(
            icon: _page == 0
                ? Icon(Icons.home_filled)
                : Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('${favorites.content.length}'),
              backgroundColor: GlobalVariables.selectedNavBarColor,
              child: _page == 1
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_outline),
            ),
            label: 'Ưu thích',
          ),
          BottomNavigationBarItem(
            icon: _page == 2
                ? const Icon(Icons.person)
                : const Icon(Icons.person_outline),
            label: 'Tôi',
          ),
        ],
      ),
    );
  }
}
