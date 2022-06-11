import 'package:catering/models/global_organization.dart';
import 'package:catering/screens/local_organizations_listing/local_organizations_listing_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class GlobalOrganizationCard extends StatelessWidget {
  final GlobalOrganization globalOrganization;

  const GlobalOrganizationCard({ Key? key, required this.globalOrganization }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        pushNewScreenWithRouteSettings(
          context,
          settings: RouteSettings(name: LocalOrganizationsListingScreen.routeName),
          screen: LocalOrganizationsListingScreen(id: globalOrganization.id),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          //width: 270,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 175,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)
                      ),
                      image: DecorationImage(
                        image: NetworkImage(globalOrganization.urlImage),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                ],
              ),
    
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(globalOrganization.name, style: Theme.of(context).textTheme.headline5),
    
                    SizedBox(height: 5),
    
                    Text(globalOrganization.category[0], style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}