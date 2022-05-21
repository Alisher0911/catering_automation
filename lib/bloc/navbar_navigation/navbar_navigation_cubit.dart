import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'constants/nav_bar_items.dart';

part 'navbar_navigation_state.dart';

class NavbarNavigationCubit extends Cubit<NavbarNavigationState> {
  NavbarNavigationCubit() : super(NavbarNavigationState(NavbarItem.home, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.home:
        emit(NavbarNavigationState(NavbarItem.home, 0));
        break;
      case NavbarItem.location:
        emit(NavbarNavigationState(NavbarItem.location, 1));
        break;
      case NavbarItem.qrCode:
        emit(NavbarNavigationState(NavbarItem.qrCode, 2));
        break;
      case NavbarItem.favourite:
        emit(NavbarNavigationState(NavbarItem.favourite, 3));
        break;
      case NavbarItem.basket:
        emit(NavbarNavigationState(NavbarItem.basket, 4));
        break;
    }
  }
}