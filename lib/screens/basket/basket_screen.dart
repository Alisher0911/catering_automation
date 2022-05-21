import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/models/voucher_model.dart';
import 'package:catering/screens/edit_basket/edit_basket_screen.dart';
import 'package:catering/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BasketScreen extends StatelessWidget {
  static const String routeName = '/basket';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => BasketScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Basket'), actions: [
          IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, "/edit-basket");
                pushNewScreenWithRouteSettings(
                  context,
                  settings: RouteSettings(name: EditBasketScreen.routeName),
                  screen: EditBasketScreen(),
                  withNavBar: true,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              icon: Icon(Icons.edit))
        ]),
        bottomNavigationBar: BottomAppBar(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 50)),
                onPressed: () {
                  // Navigator.pushNamed(context, '/checkout');
                  pushNewScreenWithRouteSettings(
                    context,
                    settings: RouteSettings(name: CheckoutScreen.routeName),
                    screen: CheckoutScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Text("Checkout"))
          ],
        )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cutlery',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Theme.of(context).colorScheme.secondary)),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Do you need a cutlery?",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      BlocBuilder<BasketBloc, BasketState>(
                        builder: (context, state) {
                          if (state is BasketLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is BasketLoaded) {
                            return SizedBox(
                                width: 100,
                                child: SwitchListTile(
                                  dense: false,
                                  value: state.basket.cutlery,
                                  onChanged: (bool? newValue) {
                                    context
                                        .read<BasketBloc>()
                                        .add(ToggleSwitch());
                                  },
                                ));
                          } else {
                            return Text("Something went wrong.");
                          }
                        },
                      )
                    ],
                  ),
                ),
                Text('Items',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Theme.of(context).colorScheme.secondary)),
                BlocBuilder<BasketBloc, BasketState>(
                  builder: (context, state) {
                    if (state is BasketLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is BasketLoaded) {
                      return state.basket.items.isEmpty
                          ? Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 5),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "No items in the Basket",
                                    textAlign: TextAlign.left,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.basket
                                  .itemQuantity(state.basket.items)
                                  .keys
                                  .length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${state.basket.itemQuantity(state.basket.items).entries.elementAt(index).value}x",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Text(
                                          "${state.basket.itemQuantity(state.basket.items).keys.elementAt(index).name}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                      Text(
                                        "\$${state.basket.itemQuantity(state.basket.items).keys.elementAt(index).price}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ],
                                  ),
                                );
                              });
                    } else {
                      return Text("Something went wrong.");
                    }
                  },
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/delivery.png'),
                      BlocBuilder<BasketBloc, BasketState>(
                        builder: (context, state) {
                          if (state is BasketLoaded) {
                            return (state.basket.deliveryTime == null)
                            ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  "Delivery in 20 minutes",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(context, "/delivery-time");
                                    pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(name: DeliveryTimeScreen.routeName),
                                      screen: DeliveryTimeScreen(),
                                      withNavBar: true,
                                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                    );
                                  },
                                  child: Text(
                                    "Change",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                  ),
                                )
                              ],
                            )

                            : Text(
                                "Delivery at ${state.basket.deliveryTime!.value}",
                                style: Theme.of(context).textTheme.headline6,
                              );
                          } else {
                            return Text("Something went wrong.");
                          }
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<BasketBloc, BasketState>(
                        builder: (context, state) {
                          if (state is BasketLoaded) {
                            return (state.basket.voucher == null)
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 20),
                                      Text(
                                        "Do you have a voucher?",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Navigator.pushNamed(context, "/voucher");
                                          pushNewScreenWithRouteSettings(
                                            context,
                                            settings: RouteSettings(name: VoucherScreen.routeName),
                                            screen: VoucherScreen(),
                                            withNavBar: true,
                                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                          );
                                        },
                                        child: Text(
                                          "Apply",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                        ),
                                      )
                                    ],
                                  )
                                : Text("Your voucher is added!",
                                    style:
                                        Theme.of(context).textTheme.headline6);
                          } else {
                            return Text("Something went wrong.");
                          }
                        },
                      ),
                      Image.asset('assets/voucher.png'),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: BlocBuilder<BasketBloc, BasketState>(
                    builder: (context, state) {
                      if (state is BasketLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is BasketLoaded) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subtotal",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  "\$${state.basket.subtotalString}",
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery Fee",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  "\$5.00",
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                ),
                                Text(
                                  "\$${state.basket.totalString}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                )
                              ],
                            )
                          ],
                        );
                      } else {
                        return Text("Something went wrong.");
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
