import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/config/text_styles.dart';
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
                  title: Text(
                    "Корзина",
                    style: Theme.of(context).textTheme.headline3!.copyWith(color: Color(0xFF8C9099)),
                  ),
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: KPrimaryColor
                  ),
                  child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(name: EditBasketScreen.routeName),
                          screen: EditBasketScreen(),
                          withNavBar: true,
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      iconSize: 26,
                      constraints: BoxConstraints(),
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                ),

                SizedBox(width: 20),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: KPrimaryColor,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),    
                    onPressed: () {
                      pushNewScreenWithRouteSettings(
                        context,
                        settings: RouteSettings(name: CheckoutScreen.routeName),
                        screen: CheckoutScreen(),
                        withNavBar: true,
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Text(
                      "Оплатить",
                      style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white),
                    )
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Продукты',
                  style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white)
                ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Нет продуктов",
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.headline6,
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.basket.itemQuantity(state.basket.items).keys.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 5),
                              padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "${state.basket.itemQuantity(state.basket.items).entries.elementAt(index).value}x",
                                    style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).colorScheme.primary),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      "${state.basket.itemQuantity(state.basket.items).keys.elementAt(index).title}",
                                      style: Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  Text(
                                    "${state.basket.itemQuantity(state.basket.items).keys.elementAt(index).price.toStringAsFixed(2)} тг",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                            );
                          }
                        );
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
                                  "Настроить доставку",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                TextButton(
                                  onPressed: () {
                                    pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(name: DeliveryTimeScreen.routeName),
                                      screen: DeliveryTimeScreen(),
                                      withNavBar: true,
                                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                    );
                                  },
                                  child: Text(
                                    "Поменять",
                                    style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).colorScheme.primary),
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
                                        "У вас есть промокод?",
                                        style: Theme.of(context).textTheme.headline6,
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
                                          "Применить",
                                          style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).colorScheme.primary),
                                        ),
                                      )
                                    ],
                                  )
                                : Text(
                                  "Your voucher is added!",
                                  style:Theme.of(context).textTheme.headline6
                                );
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
                                  "Сумма заказа",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  "${state.basket.subtotalString} тг",
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Плата за доставку",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(
                                  "500.00 тг",
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Всего",
                                  style: Theme.of(context).textTheme.headline5!.copyWith(color: Theme.of(context).colorScheme.primary),
                                ),
                                Text(
                                  "${state.basket.totalString} тг",
                                  style: Theme.of(context).textTheme.headline5!.copyWith(color: Theme.of(context).colorScheme.primary),
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
                ),
              ],
            ),
          ),
        )
    );
  }
}
