import 'dart:async';

import 'package:badges/badges.dart';
import 'package:catering/bloc/authentication/authentication_bloc.dart';
import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/bloc/userdata/userdata_bloc.dart';
import 'package:catering/config/text_styles.dart';
import 'package:catering/repositories/user_repository.dart';
import 'package:catering/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class MainScreen extends StatelessWidget {
  static const String routeName = '/main';

  const MainScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => MainScreen(), settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {

    final PersistentTabController _controller =
        PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [
        HomeScreen(),
        LocationScreen(),
        QRScannerScreen(),
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
          onPressed: (bc) {
          }
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.qrcode_viewfinder),
          iconSize: 40,
          activeColorPrimary: Color(0xFFFFC529),
          inactiveColorPrimary: Color(0xFFFFC529),
          // onPressed: (bc) {
          //   pushNewScreen(
          //     context,
          //     screen: QRScannerScreen(),
          //     withNavBar: true,
          //     pageTransitionAnimation: PageTransitionAnimation.cupertino,
          //   );
          //   // Navigator.of(bc!).push(
          //   //     MaterialPageRoute(builder: (builder) => QRScannerScreen()));
          // }
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
                    ? Icon(CupertinoIcons.shopping_cart)
                    : Badge(
                        position: BadgePosition.topEnd(top: -4),
                        badgeContent: Text(state.basket.numberOfItmems),
                        badgeColor: Color(0xFFFFC529),
                        child: Icon(
                          CupertinoIcons.shopping_cart,
                        ),
                      );
              } else {
                return Icon(
                  CupertinoIcons.shopping_cart,
                );
              }
            },
          ),
          activeColorPrimary: appColor2,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserDataBloc(userRepository: context.read<UserRepository>(), authenticationBloc: context.read<AuthenticationBloc>(), basketBloc: context.read<BasketBloc>())..add(LoadUserData()))
      ],
      child: BlocListener<UserDataBloc, UserDataState>(
        listenWhen: (context, state) {
          return state is UserDataError;
        },
        listener: (context, state) {
          if (state is UserDataError) {
            Navigator.pushReplacementNamed(context, "/root");
          }
        },
        child: PersistentTabView(
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
              navBarStyle: NavBarStyle.style6,
            ),
      ),
    );
  }
}
