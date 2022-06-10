import 'package:catering/bloc/authentication/authentication_bloc.dart';
import 'package:catering/bloc/userdata/userdata_bloc.dart';
import 'package:catering/config/text_styles.dart';
import 'package:catering/screens/order_history/order_history_screen.dart';
import 'package:catering/screens/payment_method/payment_method_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerItem(String text, IconData icon, VoidCallback callback) {
      return ListTile(
          horizontalTitleGap: 0,
          title: Text(
            text,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                fontWeight: FontWeight.normal, color: drawerTextColor),
          ),
          leading: Icon(
            icon,
            color: appColor1,
          ),
          onTap: callback
        );
    }

    final drawerHeader = BlocBuilder<UserDataBloc, UserDataState>(
      builder: (context, state) {
        if (state is UserDataLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserDataLoaded) {
          return UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background
            ),
            margin: EdgeInsets.only(top: 20),
            accountName: Text(
              state.user.username,
              style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white),
            ),
            accountEmail: Text(
              state.user.email,
              style: Theme.of(context).textTheme.headline6!.copyWith(color: drawerTextColor),
            ),
            currentAccountPicture: const CircleAvatar(
              // child: FlutterLogo(size: 42.0),
              backgroundImage: AssetImage("assets/sanat.jpeg"),
            ),
          );
        } else if (state is UserDataError) {
          return SizedBox(
            height: 150,
            child: Center(
              child: Text("Не удалось загрузить данные", style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white))
            ),
          );
        } else {
          return SizedBox(
            height: 150,
            child: Center(
              child: Text("Не удалось загрузить данные", style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white))
            ),
          );
        }
      },
    );

    final drawerItems = Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              drawerHeader,
              _buildDrawerItem(
                "Мои заказы",
                CupertinoIcons.square_list_fill,
                () {
                  pushNewScreenWithRouteSettings(
                    context,
                    settings: RouteSettings(name: OrderHistoryScreen.routeName),
                    screen: OrderHistoryScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                }
              ),
              // _buildDrawerItem(
              //   "Мой профиль",
              //   CupertinoIcons.person_crop_circle_fill,
              //   () {
              //     pushNewScreenWithRouteSettings(
              //       context,
              //       settings: RouteSettings(name: OrderHistoryScreen.routeName),
              //       screen: OrderHistoryScreen(),
              //       withNavBar: true,
              //       pageTransitionAnimation: PageTransitionAnimation.cupertino,
              //     );
              //   }
              // ),
              // _buildDrawerItem(
              //   "Адрес доставки",
              //   CupertinoIcons.location_solid,
              //   () {
              //     pushNewScreenWithRouteSettings(
              //       context,
              //       settings: RouteSettings(name: OrderHistoryScreen.routeName),
              //       screen: OrderHistoryScreen(),
              //       withNavBar: true,
              //       pageTransitionAnimation: PageTransitionAnimation.cupertino,
              //     );
              //   }
              // ),
              _buildDrawerItem(
                "Способы оплаты",
                Icons.account_balance_wallet,
                () {
                  pushNewScreenWithRouteSettings(
                    context,
                    settings: RouteSettings(name: PaymentMethodScreen.routeName),
                    screen: PaymentMethodScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                }
              ),
              // _buildDrawerItem(
              //   "Связаться с нами",
              //   CupertinoIcons.mail_solid,
              //   () {
              //     pushNewScreenWithRouteSettings(
              //       context,
              //       settings: RouteSettings(name: OrderHistoryScreen.routeName),
              //       screen: OrderHistoryScreen(),
              //       withNavBar: true,
              //       pageTransitionAnimation: PageTransitionAnimation.cupertino,
              //     );
              //   }
              // ),
              // _buildDrawerItem(
              //   "Настройки", 
              //   CupertinoIcons.gear_alt_fill,
              //   () {
              //     pushNewScreenWithRouteSettings(
              //       context,
              //       settings: RouteSettings(name: OrderHistoryScreen.routeName),
              //       screen: OrderHistoryScreen(),
              //       withNavBar: true,
              //       pageTransitionAnimation: PageTransitionAnimation.cupertino,
              //     );
              //   }
              // ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor:MaterialStateProperty.all<Color>(KPrimaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )
                )
              ),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
              icon: Icon(
                CupertinoIcons.square_arrow_left_fill,
                color: Colors.white,
              ),
              label: Text('Выйти'),
            ),
          ),
        ),
      ],
    );

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: drawerItems
    );
  }
}
