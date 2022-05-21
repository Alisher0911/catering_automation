import 'package:catering/config/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  Widget? actionButton;

  CustomAppBar({
    Key? key,
    this.actionButton
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.white30,
              blurRadius: 3.0,
            )
        ],
        color: Theme.of(context).colorScheme.background
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppBar(
            automaticallyImplyLeading: false, 
            elevation: 0,
            titleSpacing: 0,
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            leading: InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: SvgPicture.asset(
                'assets/navmenu.svg',
                width: 20,
                height: 20,
                fit: BoxFit.scaleDown
              ),
            ),
            actions: [
              actionButton ?? Container()
            ],
            title: Column(children: [
              Text(
                "Deliver to",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Color(0xFF8C9099)),
              ),
              SizedBox(height: 7),
              Text("Mangilik El 56, 77",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: appColor1))
            ]),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
