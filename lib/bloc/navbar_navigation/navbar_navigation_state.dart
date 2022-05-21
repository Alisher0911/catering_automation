part of 'navbar_navigation_cubit.dart';

class NavbarNavigationState extends Equatable {
  final NavbarItem navbarItem;
  final int index;

  const NavbarNavigationState(this.navbarItem, this.index);

  @override
  List<Object> get props => [navbarItem, index];
}