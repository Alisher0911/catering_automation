import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/bloc/local_organization/localorganization_bloc.dart';
import 'package:catering/bloc/place/place_bloc.dart';
import 'package:catering/repositories/category_repository.dart';
import 'package:catering/repositories/geolocation/geolocation_repository.dart';
import 'package:catering/repositories/restaurant_repository.dart';
import 'package:catering/widgets/organization/local_organization_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LocalOrganizationsListingScreen extends StatelessWidget {
  static const String routeName = '/local-organizations-listing';

  final int id;

  const LocalOrganizationsListingScreen({
    required this.id,
  });

  static Route route({required int id}) {
    return MaterialPageRoute(
      builder: (_) => LocalOrganizationsListingScreen(id: id),
      settings: RouteSettings(name: routeName),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocalOrganizationBloc(restaurantRepository: context.read<RestaurantRepository>(), categoryRepository: context.read<CategoryRepository>(), geolocationRepository: context.read<GeolocationRepository>(), placeBloc: context.read<PlaceBloc>(), basketBloc: context.read<BasketBloc>())..add(LoadLocalOrganizationsByGlobalId(id: id)),
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Container(
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
                    leading: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )
                    ),
                    title: Text(
                      "Филиалы",
                      style: Theme.of(context).textTheme.headline3!.copyWith(color: Color(0xFF8C9099)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<LocalOrganizationBloc, LocalOrganizationState>(
              builder: (context, state) {
                if (state is LocalOrganizationsByGlobalIdLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LocalOrganizationsByGlobalIdLoaded) {
                  return ListView.builder(
                    itemCount: state.localOrganizations.length,
                    itemBuilder: (context, index) {
                      return LocalOrganizationCard(localOrganization: state.localOrganizations[index]);
                    }
                  );
                }
                else if (state is LocalOrganizationsByGlobalIdError) {
                  return Center(
                    child: Text(
                      "Не удалось загрузить организации", 
                      style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white)
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "Не удалось загрузить организации", 
                      style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white)
                    ),
                  );
                }
              },
            ),
          )
        ),
    );
  }
}
