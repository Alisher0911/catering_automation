import 'package:catering/bloc/authentication/authentication_bloc.dart';
import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/bloc/filter/filter_bloc.dart';
import 'package:catering/bloc/geolocation/geolocation_bloc.dart';
import 'package:catering/bloc/local_organization/localorganization_bloc.dart';
import 'package:catering/bloc/menu_item_quantity/menuitemquantity_cubit.dart';
import 'package:catering/bloc/navbar_navigation/navbar_navigation_cubit.dart';
import 'package:catering/bloc/order/order_bloc.dart';
import 'package:catering/bloc/place/place_bloc.dart';
import 'package:catering/bloc/restaurant/restaurant_bloc.dart';
import 'package:catering/config/app_router.dart';
import 'package:catering/config/theme.dart';
import 'package:catering/repositories/category_repository.dart';
import 'package:catering/repositories/geolocation/geolocation_repository.dart';
import 'package:catering/repositories/order_repository.dart';
import 'package:catering/repositories/restaurant_repository.dart';
import 'package:catering/repositories/user_repository.dart';
import 'package:catering/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('${bloc.runtimeType} $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}


void main() {
  final userRepository = UserRepository();
  BlocOverrides.runZoned(
   () {
     runApp(MyApp());
   },
   blocObserver: SimpleBlocObserver(),
 );
  // runApp(const MyApp());
}


class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RestaurantRepository>(create: (_) => RestaurantRepository()),
        RepositoryProvider<GeolocationRepository>(create: (_) => GeolocationRepository()),
        RepositoryProvider<UserRepository>(create: (_) => UserRepository()),
        RepositoryProvider<CategoryRepository>(create: (_) => CategoryRepository()),
        RepositoryProvider<OrderRepository>(create: (_) => OrderRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GeolocationBloc(geolocationRepository: context.read<GeolocationRepository>())..add(LoadGeolocation())),
          BlocProvider(create: (context) => NavbarNavigationCubit()),
          BlocProvider(create: (context) => MenuItemQuantityCubit()),
          BlocProvider(create: (context) => FilterBloc()..add(FilterLoad())),
          BlocProvider(create: (context) => BasketBloc()..add(StartBasket())),
          BlocProvider(create: (context) => OrderBloc(orderRepository: context.read<OrderRepository>())),
          BlocProvider(create: (context) => PlaceBloc(geolocationRepository: context.read<GeolocationRepository>())),
          BlocProvider(create: (context) => AuthenticationBloc(userRepository: context.read<UserRepository>(), basketBloc: context.read<BasketBloc>())..add(AppStarted())),
          // BlocProvider(create: (context) => CategoryBloc(categoryRepository: context.read<CategoryRepository>())),
          // BlocProvider(create: (context) => UserDataBloc(userRepository: context.read<UserRepository>(), authenticationBloc: BlocProvider.of<AuthenticationBloc>(context))),
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