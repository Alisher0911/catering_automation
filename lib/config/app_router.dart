import 'package:catering/models/restaurant_model.dart';
import 'package:catering/screens/root/root_screen.dart';
import 'package:catering/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGeneratedRoute(RouteSettings settings) {
    switch(settings.name) {
      case HomeScreen.routeName:
        return HomeScreen.route();
      case StartupScreen.routeName:
        return StartupScreen.route();
      case OnboardingScreen.routeName:
        return OnboardingScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case RegistrationScreen.routeName:
        return RegistrationScreen.route();
      case RootScreen.routeName:
        return RootScreen.route();
      case LocationScreen.routeName:
        return LocationScreen.route();
      case BasketScreen.routeName:
        return BasketScreen.route();
      case EditBasketScreen.routeName:
        return EditBasketScreen.route();
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      case DeliveryTimeScreen.routeName:
        return DeliveryTimeScreen.route();
      case FilterScreen.routeName:
        return FilterScreen.route();
      // case RestaurantDetailsScreen.routeName:
      //   return RestaurantDetailsScreen.route(
      //     restaurant: settings.arguments as Restaurant
      //   );
      // case RestaurantListingScreen.routeName:
      //   return RestaurantListingScreen.route(
      //     restaurants: settings.arguments as List<Restaurant>
      //   );
      case VoucherScreen.routeName:
        return VoucherScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('error')),
        ),
        settings: const RouteSettings(name: '/error'));
  }
}