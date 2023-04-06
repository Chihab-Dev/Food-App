import 'package:flutter/material.dart';
import 'package:food_app/presentation/resources/appsize.dart';
import 'package:food_app/presentation/resources/color_manager.dart';
import 'package:food_app/presentation/resources/strings_manager.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'view/pages/home/view/home_screen.dart';
import 'view/pages/profile/view/profile_screen.dart';
import 'view/pages/search/view/search_screen.dart';
import 'view/pages/shop/view/shop_screen.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const ShopScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    return Container(
      color: ColorManager.white,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: GNav(
          backgroundColor: ColorManager.white,
          color: ColorManager.grey,
          activeColor: ColorManager.white,
          tabBackgroundColor: ColorManager.orange,
          padding: const EdgeInsets.all(AppPadding.p16),
          gap: AppSize.s10,
          onTabChange: (value) => onTap(value),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: AppStrings.home,
            ),
            GButton(
              icon: Icons.search,
              text: AppStrings.search,
            ),
            GButton(
              icon: Icons.shopping_cart_outlined,
              text: AppStrings.shop,
            ),
            GButton(
              icon: Icons.person,
              text: AppStrings.profile,
            ),
          ],
        ),
      ),
    );
  }

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
