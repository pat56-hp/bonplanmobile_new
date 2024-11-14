import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/views/exploreScreen.dart';
import 'package:mobile/views/FavorisScreen.dart';
import 'package:mobile/views/homeScreen.dart';
import 'package:mobile/views/profilScreen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  static final List _widgetOption = [
    HomeScreen(),
    const ExploreScreen(),
    const FavorisScreen(),
    const ProfilScreen()
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _widgetOption.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Color.fromARGB(63, 224, 79, 103), width: 1),
          ),
        ),
        child: NavigationBar(
          backgroundColor: backgroundColorWhite,
          onDestinationSelected: _onItemSelected,
          indicatorColor: Colors.transparent,
          selectedIndex: _selectedIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          shadowColor: activeNavigationBarItem,
          elevation: 10,
          destinations: [
            navigationItem(
                index: 0,
                selectedIndex: _selectedIndex,
                label: 'Accueil',
                activeIcon: 'assets/icons/home-active.svg',
                icon: 'assets/icons/home.svg'),
            navigationItem(
                index: 1,
                selectedIndex: _selectedIndex,
                label: 'Explorer',
                activeIcon: 'assets/icons/search-active.svg',
                icon: 'assets/icons/search.svg'),
            navigationItem(
                index: 2,
                selectedIndex: _selectedIndex,
                label: 'Favoris',
                activeIcon: 'assets/icons/heart-active.svg',
                icon: 'assets/icons/heart.svg'),
            navigationItem(
                index: 3,
                selectedIndex: _selectedIndex,
                label: 'Profil',
                activeIcon: 'assets/icons/user-active.svg',
                icon: 'assets/icons/user.svg'),
          ],
        ),
      ),
    );
  }
}

class navigationItem extends StatelessWidget {
  const navigationItem(
      {super.key,
      required this.index,
      required this.selectedIndex,
      required this.label,
      required this.activeIcon,
      required this.icon});
  final int index;
  final int selectedIndex;
  final String label;
  final String icon;
  final String activeIcon;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      selectedIcon: Container(
        padding: const EdgeInsets.all(8.0),
        height: 48,
        decoration: BoxDecoration(
            color: activeNavigationBarItem,
            borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              activeIcon,
              height: bottomNavigationIcon,
              width: bottomNavigationIcon,
              color: textRed,
            ),
            const SizedBox(width: 4),
            Visibility(
              visible: selectedIndex == index,
              child: Text(
                label,
                style: const TextStyle(
                    color: textRed,
                    fontSize: bottonNavigationText,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      icon: SvgPicture.asset(
        icon,
        height: bottomNavigationIcon,
        width: bottomNavigationIcon,
        color: iconColor,
      ),
      label: label,
    );
  }
}
