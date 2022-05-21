import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/bloc/filter/filter_bloc.dart';
import 'package:catering/bloc/menu_item_quantity/menuitemquantity_cubit.dart';
import 'package:catering/bloc/navbar_navigation/navbar_navigation_cubit.dart';
import 'package:catering/bloc/restaurant/restaurant_bloc.dart';
import 'package:catering/config/app_router.dart';
import 'package:catering/config/theme.dart';
import 'package:catering/repositories/restaurant_repository.dart';
import 'package:catering/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RestaurantRepository>(
          create: (_) => RestaurantRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NavbarNavigationCubit()),
          BlocProvider(create: (context) => MenuItemQuantityCubit()),
          BlocProvider(create: (context) => FilterBloc()..add(FilterLoad())),
          BlocProvider(create: (context) => BasketBloc()..add(StartBasket())),
          BlocProvider(create: (context) => RestaurantBloc(context.read<RestaurantRepository>())..add(LoadRestaurants())),
        ],
        child: MaterialApp(
          title: 'Happy Food',
          theme: theme(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGeneratedRoute,
          initialRoute: StartupScreen.routeName,
        ),
      ),
    );
  }
}