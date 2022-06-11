import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/bloc/order/order_bloc.dart';
import 'package:catering/repositories/order_repository.dart';
import 'package:catering/screens/order_history/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoryScreen extends StatelessWidget {

  static const String routeName = '/order-history';

  static Route route({required int id}) {
    return MaterialPageRoute(
      builder: (_) => OrderHistoryScreen(),
      settings: RouteSettings(name: routeName),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OrderBloc(orderRepository: context.read<OrderRepository>(), basketBloc: context.read<BasketBloc>())..add(LoadOrderHisory())),
      ],
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
                    "Мои заказы",
                    style: Theme.of(context).textTheme.headline3!.copyWith(color: Color(0xFF8C9099)),
                  ),
                ),
              ],
            ),
          ),
        ),
    
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderHistoryLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is OrderHistoryLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  color: Colors.white,
                  onRefresh: () async {
                    context.read<OrderBloc>().add(LoadOrderHisory());
                  },
                  child: ListView.builder(
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) {
                      return OrderCard(order: state.orders[index]);
                    }
                  ),
                ),
              );
            } else if (state is OrderHistoryFailure) {
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
      ),
    );
  }
}