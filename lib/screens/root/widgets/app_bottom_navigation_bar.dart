import 'package:badges/badges.dart';
import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/bloc/navbar_navigation/constants/nav_bar_items.dart';
import 'package:catering/bloc/navbar_navigation/navbar_navigation_cubit.dart';
import 'package:catering/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarNavigationCubit, NavbarNavigationState>(
        builder: (context, state) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).colorScheme.background,
      selectedItemColor: appColor2,
      unselectedItemColor: Colors.white,
      currentIndex: state.index,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.location_on,
          ),
          label: 'Location',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.qr_code_scanner,
            size: 30,
            color: Color(0xFFFFC529),
          ),
          label: 'QR',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
          ),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: BlocBuilder<BasketBloc, BasketState>(
            builder: (context, state) {
              if (state is BasketLoaded) {
                return state.basket.items.isEmpty
                  ? Icon(Icons.shopping_cart)
                  : Badge(
                    badgeContent: Text(state.basket.numberOfItmems),
                    badgeColor: Color(0xFFFFC529),
                    child: Icon(
                      Icons.shopping_cart,
                    ),
                  );
              } else {
                return Icon(
                  Icons.shopping_cart,
                );
              }
              
            },
          ),
          label: 'Basket',
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          BlocProvider.of<NavbarNavigationCubit>(context)
              .getNavBarItem(NavbarItem.home);
        } else if (index == 1) {
          BlocProvider.of<NavbarNavigationCubit>(context)
              .getNavBarItem(NavbarItem.location);
        } else if (index == 2) {
          BlocProvider.of<NavbarNavigationCubit>(context)
              .getNavBarItem(NavbarItem.qrCode);
        } else if (index == 3) {
          BlocProvider.of<NavbarNavigationCubit>(context)
              .getNavBarItem(NavbarItem.favourite);
        } else if (index == 4) {
          BlocProvider.of<NavbarNavigationCubit>(context)
              .getNavBarItem(NavbarItem.basket);
        }
      },
    );
        },
      );
  }
}