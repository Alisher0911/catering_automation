import 'package:catering/bloc/restaurant/restaurant_bloc.dart';
import 'package:catering/models/global_organization.dart';
import 'package:catering/screens/local_organizations_listing/local_organizations_listing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class OrganizationSearchBox extends StatelessWidget {
  const OrganizationSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: BlocBuilder<RestaurantBloc, RestaurantState>(
              builder: (context, state) {
                return TypeAheadField(
                  keepSuggestionsOnLoading: false,
                  textFieldConfiguration: TextFieldConfiguration(
                    autocorrect: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Какую организацию вы ищете?",
                      suffixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.primary
                      ),
                      contentPadding: const EdgeInsets.only(left: 20, bottom: 5, top: 12.5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  ),
                  suggestionsBoxDecoration: SuggestionsBoxDecoration(
                    elevation: 20,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  suggestionsCallback: (pattern) {
                      return (state is GlobalOrganizationLoaded)
                      ? state.globalOrganizations.where((go) => go.name.toLowerCase().contains(pattern.toLowerCase()))
                      : <GlobalOrganization>[];
                  },
                  itemBuilder: (context, GlobalOrganization? suggestion) {
                    final org = suggestion!;
                    return ListTile(
                      dense: true,
                      title: Text(
                        org.name,
                        style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.normal),
                      ),
                    );
                  },
                  noItemsFoundBuilder: (context) => SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Не удалось найти организацию",
                        style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  onSuggestionSelected: (GlobalOrganization? suggestion) {
                    final org = suggestion!;
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: RouteSettings(name: LocalOrganizationsListingScreen.routeName),
                      screen: LocalOrganizationsListingScreen(id: org.id),
                      withNavBar: true,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                  }
                );
              },
            ),
          ),
          // Expanded(
          //   child: TextField(
          //     decoration: InputDecoration(
          //       filled: true,
          //       fillColor: Colors.white,
          //       hintText: "Что бы вы хотели съесть?",
          //       suffixIcon: Icon(
          //         Icons.search,
          //         color: Theme.of(context).colorScheme.primary
          //       ),
          //       contentPadding: const EdgeInsets.only(left: 20, bottom: 5, top: 12.5),
          //       focusedBorder: OutlineInputBorder(
          //         borderSide: BorderSide(color: Colors.white),
          //         borderRadius: BorderRadius.circular(10)
          //       ),
          //       enabledBorder: UnderlineInputBorder(
          //         borderSide: BorderSide(color: Colors.white),
          //         borderRadius: BorderRadius.circular(10)
          //       )
          //     ),
          //   ),
          // ),

          // SizedBox(width: 10),

          // Container(
          //   width: 50,
          //   height: 50,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(5),

          //   ),
          //   child: IconButton(
          //       icon: Icon(Icons.menu),
          //       color: Theme.of(context).colorScheme.primary,
          //       splashColor: Colors.transparent,
          //       highlightColor: Colors.transparent,
          //       onPressed: () {
          //         // Navigator.pushNamed(context, '/filter');
          //         pushNewScreenWithRouteSettings(
          //           context,
          //           settings: RouteSettings(name: FilterScreen.routeName),
          //           screen: FilterScreen(),
          //           withNavBar: true,
          //           pageTransitionAnimation: PageTransitionAnimation.cupertino,
          //         );
          //       },
          //   ),
          // )
        ],
      ),
    );
  }
}