import 'package:badges/badges.dart';
import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/bloc/navbar_navigation/constants/nav_bar_items.dart';
import 'package:catering/bloc/navbar_navigation/navbar_navigation_cubit.dart';
import 'package:catering/config/text_styles.dart';
import 'package:catering/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class RootScreen extends StatefulWidget {
  static const String routeName = '/root';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => RootScreen(), settings: RouteSettings(name: routeName));
  }

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  // @override
  // Widget build(BuildContext context) {
  //   return BlocBuilder<NavbarNavigationCubit, NavbarNavigationState>(
  //     builder: (context, state) {
  //       return Scaffold(
  //         bottomNavigationBar: AppBottomNavigationBar(),
  //         body: BlocBuilder<NavbarNavigationCubit, NavbarNavigationState>(
  //           builder: (context, state) {
  //             if (state.navbarItem == NavbarItem.home) {
  //               return HomeScreen();
  //             } else if (state.navbarItem == NavbarItem.location) {
  //               return LocationScreen();
  //             } else if (state.navbarItem == NavbarItem.qrCode) {
  //               return QRCodeScreen();
  //             } else if (state.navbarItem == NavbarItem.favourite) {
  //               return FavouriteScreen();
  //             } else if (state.navbarItem == NavbarItem.basket) {
  //               return BasketScreen();
  //             }
  //             return Container();
  //           }
  //         ),
  //       );
  //     },
  //   );
  // } 


  @override
  Widget build(BuildContext context) {

    final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

     List<Widget> _buildScreens() {
      return [
        HomeScreen(),
        LocationScreen(),
        QRCodeScreen(),
        FavouriteScreen(),
        BasketScreen()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          activeColorPrimary: appColor2,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.location_solid),
          activeColorPrimary: appColor2,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.qrcode_viewfinder),
          iconSize: 40,
          activeColorPrimary: Color(0xFFFFC529),
          inactiveColorPrimary: Color(0xFFFFC529),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.heart_fill),
          activeColorPrimary: appColor2,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: BlocBuilder<BasketBloc, BasketState>(
            builder: (context, state) {
              if (state is BasketLoaded) {
                return state.basket.items.isEmpty
                  ? Icon(Icons.shopping_cart)
                  : Badge(
                    badgeContent: Text(state.basket.numberOfItmems),
                    badgeColor: Color(0xFFFFC529),
                    child: Icon(
                      CupertinoIcons.shopping_cart,
                    ),
                  );
              } else {
                return Icon(
                  Icons.shopping_cart,
                );
              }
            },
          ),
          activeColorPrimary: appColor2,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }


    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(5.0),
          colorBehindNavBar: Theme.of(context).colorScheme.background,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        // 6 13 16 neum
        navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}