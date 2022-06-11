import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/bloc/local_organization/localorganization_bloc.dart';
import 'package:catering/bloc/place/place_bloc.dart';
import 'package:catering/models/category_model.dart';
import 'package:catering/models/menu_item_model.dart';
import 'package:catering/repositories/category_repository.dart';
import 'package:catering/repositories/geolocation/geolocation_repository.dart';
import 'package:catering/repositories/restaurant_repository.dart';
import 'package:catering/screens/local_organization_details/widgets/menu_item_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'widgets/glassmorphism.dart';
import 'package:flutter/material.dart';

import 'widgets/restaurant_information.dart';

class LocalOrganizationDetailsScreen extends StatelessWidget {
  static const String routeName = '/local-organization-details';

  final int id;

  const LocalOrganizationDetailsScreen({required this.id});

  static Route route({required int id}) {
    return MaterialPageRoute(
        builder: (_) => LocalOrganizationDetailsScreen(id: id),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocalOrganizationBloc(restaurantRepository: context.read<RestaurantRepository>(), categoryRepository: context.read<CategoryRepository>(), geolocationRepository: context.read<GeolocationRepository>(), placeBloc: context.read<PlaceBloc>(), basketBloc: context.read<BasketBloc>())..add(LoadLocalOrganizationById(id: id))),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: BlocBuilder<LocalOrganizationBloc, LocalOrganizationState>(
          builder: (context, state) {
            if (state is LocalOrganizationByIdLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (state is LocalOrganizationByIdLoaded) {
              return  SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.elliptical(
                                MediaQuery.of(context).size.width, 30 //50
                              )
                            ),
                            image: DecorationImage(
                              image: NetworkImage(state.localOrganization.urlImage),
                              fit: BoxFit.cover
                            )
                          ),
                        ),
        
                        Positioned(
                          bottom: 20,
                          child: Glassmorphism(
                            blur: 15,
                            opacity: 0.1,
                            child: LocalOrganizationInformation(localOrganization: state.localOrganization),
                          ),
                        )
                      ],
                    ),
        
                    SizedBox(height: 20),
                    
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        return _buildMenuItems(context, state.categories[index], state.menuItems);
                      }
                    ),
                    
                    SizedBox(height: 20),
                  ],
                ),
              );
            }
            else if (state is LocalOrganizationByIdError) {
              return Center(
                child: Text(
                  "Не удалось загрузить организацию",
                  style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white)
                ),
              );
            } else {
              return Center(
                child: Text(
                  "Не удалось загрузить организацию",
                  style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white)
                ),
              );
            }
          },
        )
      )
    );
  }

  Widget _buildMenuItems(BuildContext context, Category category, List<FoodMenuItem> menuItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        menuItems.where((menuItem) => menuItem.listType == category.id).isEmpty
        ? Container()
        : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            category.name,
            style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            children: menuItems
                .where((menuItem) => menuItem.listType == category.id)
                .map((menuItem) => MenuItemCard(menuItem: menuItem))
                .toList()
          ),
        ),
      ],
    );
  }
}