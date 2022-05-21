import 'package:catering/config/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerItem(String text, IconData icon) {
      return ListTile(
        horizontalTitleGap: 0,
        title: Text(
          text,
          style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.normal, color: drawerTextColor),
        ),
        leading: Icon(
          icon,
          color: appColor1,
        ),
        onTap: () {
          Navigator.pop(context);
        }
      );
    }

    final drawerHeader = UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background
      ),
      margin: EdgeInsets.only(top: 20),
      accountName: Text(
        "Sanat Sherim",
        style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white),
      ),
      accountEmail: Text(
        "mister.sherim@gmail.com",
        style: Theme.of(context).textTheme.headline6!.copyWith(color: drawerTextColor),
      ),
      currentAccountPicture: const CircleAvatar(
        // child: FlutterLogo(size: 42.0),
        backgroundImage: AssetImage("assets/sanat.jpeg"),
      ),
    );

    final drawerItems = Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              drawerHeader,
              _buildDrawerItem("Мои заказы", CupertinoIcons.square_list_fill),
              _buildDrawerItem("Мой профиль", CupertinoIcons.person_crop_circle_fill),
              _buildDrawerItem("Адрес доставки", CupertinoIcons.location_solid),
              _buildDrawerItem("Способы оплаты", Icons.account_balance_wallet),
              _buildDrawerItem("Связаться с нами", CupertinoIcons.mail_solid),
              _buildDrawerItem("Настройки", CupertinoIcons.gear_alt_fill),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(KPrimaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )
                )
              ),
              onPressed: () {
                // Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                Navigator.of(context, rootNavigator: true).pushReplacementNamed("/login");
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
      child: drawerItems,
    );
  }
}