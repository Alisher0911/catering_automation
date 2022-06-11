import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/bloc/order/order_bloc.dart';
import 'package:catering/config/text_styles.dart';
import 'package:catering/models/order_model.dart';
import 'package:catering/repositories/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({ Key? key, required this.order }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity(vertical: 4),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Код заказа: ${order.id}",
              style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),
            ),
            Text(
              "Сумма заказа: ${order.totalCost}",
              style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 110,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                minimumSize: const Size.fromHeight(40),
                side: BorderSide(width: 2, color: KPrimaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
            onPressed: () {
              _showOrderItems(context, order.id);
            },
            child: Text(
              "Подробно",
              style: Theme.of(context).textTheme.headline4!.copyWith(color: KPrimaryColor),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showOrderItems(BuildContext context, int id) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          title: Center(
            child: Text(
              "Подробно", 
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          content: BlocProvider(
            create: (context) => OrderBloc(orderRepository: context.read<OrderRepository>(), basketBloc: context.read<BasketBloc>())..add(LoadOrderItems(id)),
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderItemsLoading) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    height: 50,
                    child: Center(child: CircularProgressIndicator())
                  );
                } else if (state is OrderItemsLoaded) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width - 30,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.orderItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  state.orderItems[index].foodName,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Theme.of(context).colorScheme.primary),
                                  children: [
                                    TextSpan(text: "${state.orderItems[index].psc}x  "),
                                    TextSpan(
                                      text: "${state.orderItems[index].price} тг",
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
                } else if (state is OrderItemsFailure) {
                  return Center(
                    child: Text(
                      "Не удалось загрузить историю заказов", 
                      style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white)
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "Не удалось загрузить историю заказов", 
                      style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white)
                    ),
                  );
                }
              },
            ),
          )
        );
      },
    );
  }
}