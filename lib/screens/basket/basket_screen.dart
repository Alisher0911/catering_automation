import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/bloc/order/order_bloc.dart';
import 'package:catering/config/text_styles.dart';
import 'package:catering/models/payment_card.dart';
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

                BlocBuilder<BasketBloc, BasketState>(
                  builder: (context, basketState) {
                    return BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, orderState) {
                        return Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: KPrimaryColor,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),    
                            onPressed: () {
                              if (basketState is BasketLoaded) {
                                if (basketState.basket.items.isNotEmpty && basketState.basket.paymentCard != null) {
                                  context.read<OrderBloc>().add(CreateOrder(basketState.basket));
                                  showSuccessDialog(context);
                                } else {
                                  showErrorDialog(context);
                                }
                              }
                            },
                            child: Text(
                              "Оплатить",
                              style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white),
                            )
                          ),
                        );
                      },
                    );
                  },
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
                      : Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.basket.itemQuantity(state.basket.items).keys.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30)
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(state.basket.itemQuantity(state.basket.items).keys.elementAt(index).urlImage),
                                          fit: BoxFit.fitHeight
                                        )
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        "${state.basket.itemQuantity(state.basket.items).keys.elementAt(index).title}",
                                        style: Theme.of(context).textTheme.headline6,
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).colorScheme.primary),
                                        children: [
                                          TextSpan(text: "${state.basket.itemQuantity(state.basket.items).entries.elementAt(index).value}x  "),
                                          TextSpan(
                                            text: "${state.basket.itemQuantity(state.basket.items).keys.elementAt(index).price.toStringAsFixed(2)} тг",
                                            style: Theme.of(context).textTheme.headline6,
                                          ),
                                        ]
                                      )
                                    ),
                                  ],
                                ),
                              );
                            }
                          ),
                      );
                    } else {
                      return Text("Something went wrong.");
                    }
                  },
                ),
                // Container(
                //   width: double.infinity,
                //   height: 100,
                //   margin: EdgeInsets.only(top: 5),
                //   padding: EdgeInsets.symmetric(horizontal: 30),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Image.asset('assets/delivery.png'),
                //       BlocBuilder<BasketBloc, BasketState>(
                //         builder: (context, state) {
                //           if (state is BasketLoaded) {
                //             return (state.basket.deliveryTime == null)
                //             ? Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 SizedBox(height: 20),
                //                 Text(
                //                   "Настроить доставку",
                //                   style: Theme.of(context).textTheme.headline6,
                //                 ),
                //                 TextButton(
                //                   onPressed: () {
                //                     pushNewScreenWithRouteSettings(
                //                       context,
                //                       settings: RouteSettings(name: DeliveryTimeScreen.routeName),
                //                       screen: DeliveryTimeScreen(),
                //                       withNavBar: true,
                //                       pageTransitionAnimation: PageTransitionAnimation.cupertino,
                //                     );
                //                   },
                //                   child: Text(
                //                     "Поменять",
                //                     style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).colorScheme.primary),
                //                   ),
                //                 )
                //               ],
                //             )

                //             : Text(
                //                 "Delivery at ${state.basket.deliveryTime!.value}",
                //                 style: Theme.of(context).textTheme.headline6,
                //               );
                //           } else {
                //             return Text("Something went wrong.");
                //           }
                //         },
                //       )
                //     ],
                //   ),
                // ),
                // Container(
                //   width: double.infinity,
                //   height: 100,
                //   margin: EdgeInsets.only(top: 5),
                //   padding: EdgeInsets.symmetric(horizontal: 30),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       BlocBuilder<BasketBloc, BasketState>(
                //         builder: (context, state) {
                //           if (state is BasketLoaded) {
                //             return (state.basket.voucher == null)
                //                 ? Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       SizedBox(height: 20),
                //                       Text(
                //                         "У вас есть промокод?",
                //                         style: Theme.of(context).textTheme.headline6,
                //                       ),
                //                       TextButton(
                //                         onPressed: () {
                //                           // Navigator.pushNamed(context, "/voucher");
                //                           pushNewScreenWithRouteSettings(
                //                             context,
                //                             settings: RouteSettings(name: VoucherScreen.routeName),
                //                             screen: VoucherScreen(),
                //                             withNavBar: true,
                //                             pageTransitionAnimation: PageTransitionAnimation.cupertino,
                //                           );
                //                         },
                //                         child: Text(
                //                           "Применить",
                //                           style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).colorScheme.primary),
                //                         ),
                //                       )
                //                     ],
                //                   )
                //                 : Text(
                //                   "Your voucher is added!",
                //                   style:Theme.of(context).textTheme.headline6
                //                 );
                //           } else {
                //             return Text("Something went wrong.");
                //           }
                //         },
                //       ),
                //       Image.asset('assets/voucher.png'),
                //     ],
                //   ),
                // ),

                SizedBox(height: 20),

                Text('Способ оплаты',
                  style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white)
                ),
                BlocBuilder<BasketBloc, BasketState>(
                  builder: (context, state) {
                    if (state is BasketLoaded) {
                      return (state.basket.paymentCard == null) 
                      ? InkWell(
                        onTap: () {
                          _showPaymentMethods(context);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_box,
                              color: Colors.white,
                              size: 50,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Выбрать способ оплаты",
                              style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white70),
                            )
                          ],
                        )
                      )
                      : InkWell(
                        onTap: () {
                          _showPaymentMethods(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40,
                                child: Image.asset(
                                  state.basket.paymentCard!.image
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
                                    children: [
                                      TextSpan(
                                        text: "**** **** **** "
                                      ),
                                      TextSpan(
                                        text: state.basket.paymentCard!.cardNumber.substring(state.basket.paymentCard!.cardNumber.length - 4),
                                      )
                                    ]
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Text("Somethin went wrong.");
                    }
                    
                  },
                ),

                SizedBox(height: 20),

                BlocBuilder<BasketBloc, BasketState>(
                  builder: (context, state) {
                    if (state is BasketLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is BasketLoaded) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Сумма заказа",
                                style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white70),
                              ),
                              Text(
                                "${state.basket.subtotalString} тг",
                                style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white70),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Плата за доставку",
                                style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white70),
                              ),
                              Text(
                                "500.00 тг",
                                style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white70),
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Всего",
                                style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),
                              ),
                              Text(
                                "${state.basket.totalString} тг",
                                style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),
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
              ],
            ),
          ),
        )
    );
  }



  Future<void> showSuccessDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.greenAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          title: Text("Успех",
            style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white)
          ),
          content: Text(
            "Ваш заказ успешно добавлен",
            style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white, fontWeight: FontWeight.normal)
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ), 
                onPressed: () {
                  Navigator.of(dialogContext).pop(false);
                },
                child: Text("Ок", style: TextStyle(color: Colors.greenAccent))
              ),
            ),
          ],
        );
      }
    );
  }

  Future<void> showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          title: Text("Ошибка", 
            style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white)
          ),
          content: Text(
            "Ваша корзина пустая\nЛибо вы не выбрали способ оплаты",
            style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white, fontWeight: FontWeight.normal)
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ), 
                onPressed: () {
                  Navigator.of(dialogContext).pop(false);
                },
                child: Text("Ок", style: TextStyle(color: Colors.redAccent))
              ),
            ),
          ],
        );
      }
    );
  }

  Future<void> _showPaymentMethods(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          title: Text("Способ оплаты"),
          content: SizedBox(
            width: MediaQuery.of(context).size.width - 30,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: PaymentCard.paymentCards.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: InkWell(
                    onTap: () {
                      context.read<BasketBloc>().add(AddPaymentCard(PaymentCard.paymentCards[index]));
                      Navigator.of(dialogContext).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Image.asset(
                            PaymentCard.paymentCards[index].image
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.headline6,
                              children: [
                                TextSpan(
                                  text: "**** **** **** "
                                ),
                                TextSpan(
                                  text: PaymentCard.paymentCards[index].cardNumber.substring(PaymentCard.paymentCards[index].cardNumber.length - 4),
                                )
                              ]
                            )
                          ),
                        ),
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(Icons.arrow_forward_ios_outlined),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
          )
        );
      },
    );
  }
}
