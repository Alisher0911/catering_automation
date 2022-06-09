import 'package:catering/bloc/category/category_bloc.dart';
import 'package:catering/bloc/place/place_bloc.dart';
import 'package:catering/bloc/restaurant/restaurant_bloc.dart';
import 'package:catering/models/category_model.dart';
import 'package:catering/models/promo_model.dart';
import 'package:catering/repositories/category_repository.dart';
import 'package:catering/repositories/restaurant_repository.dart';
import 'package:catering/screens/global_organizations_listing/global_organizations_listing_screen.dart';
import 'package:catering/screens/home/widgets/navigation_drawer.dart';
import 'package:catering/widgets/category_box.dart';
import 'package:catering/screens/home/widgets/organization_search_box.dart';
import 'package:catering/widgets/organization/global_organization_card.dart';
import 'package:catering/widgets/promo_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => HomeScreen(), settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoryBloc(categoryRepository: context.read<CategoryRepository>())..add(LoadCategories())),
        BlocProvider(create: (context) => RestaurantBloc(restaurantRepository: context.read<RestaurantRepository>(), placeBloc: context.read<PlaceBloc>())..add(LoadGlobalOrganizations())),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: CustomAppBar(
          actionButton: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(CupertinoIcons.person_alt_circle, size: 40),
              onPressed: () {},
            ),
          ),
        ),
        drawer: NavigationDrawer(),
        body: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (context, state) {
            if (state is GlobalOrganizationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GlobalOrganizationLoaded) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 100,  
                        child: BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, categoryState) {
                            if (categoryState is CategoryLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } 
                            else if (categoryState is CategoryLoaded) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: categoryState.categories.length,
                                itemBuilder: ((context, index) {
                                  return CategoryBox(
                                    category: categoryState.categories[index], globalOrganizations: (state is GlobalOrganizationLoaded) ? state.globalOrganizations : []
                                  );
                                })
                              );
                            }
                            else if (categoryState is CategoryError) {
                              return Center(
                                child: Text("Не удалось загрузить категории", style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white)),
                              );
                            }
                            else {
                              return Center(
                                child: Text("Не удалось загрузить категории", style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white)),
                              );
                            }
                          },
                        ),
                      ),
                    ),
      
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 125,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: Promo.promos.length,
                          itemBuilder: (context, index) {
                            return PromoBox(promo: Promo.promos[index]);
                          }
                        ),
                      ),
                    ),
      
                    OrganizationSearchBox(),
      
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Организации",
                            style: Theme.of(context).textTheme.headline3!.copyWith(fontStyle: FontStyle.italic, fontFamily: "Nunito", fontWeight: FontWeight.w700, color: Colors.white)
                          )
                      )
                    ),
                  
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.globalOrganizations.length,
                      itemBuilder: (context, index) {
                        return GlobalOrganizationCard(
                            globalOrganization: state.globalOrganizations[index]);
                      }
                    )
                  ],
                )
              );
            } else if (state is GlobalOrganizationError) {
              return Center(
                child: Text("Не удалось загрузить данные", style: TextStyle(color: Colors.white)),
              );
            } else {
              return Center(
                child: Text("Не удалось загрузить данные", style: TextStyle(color: Colors.white)),
              );
            }
            
          },
        ),
      )
    );
  }
}