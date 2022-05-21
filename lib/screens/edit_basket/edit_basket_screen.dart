import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditBasketScreen extends StatelessWidget {
  static const String routeName = '/edit-basket';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => EditBasketScreen(),
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
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )
                  ),
                  title: Text(
                    "Редактировать заказ",
                    style: Theme.of(context).textTheme.headline3!.copyWith(color: Color(0xFF8C9099)),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Items',
                  style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white)
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
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "No items in the Basket",
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
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "${state.basket.itemQuantity(state.basket.items).entries.elementAt(index).value}x",
                                style: Theme.of(context).textTheme.headline6!
                                          .copyWith(color: Theme.of(context).colorScheme.primary),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  "${state.basket.itemQuantity(state.basket.items).keys.elementAt(index).name}",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),

                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  context.read<BasketBloc>().add(RemoveAllItem(state.basket.itemQuantity(state.basket.items).keys.elementAt(index)));
                                },
                                icon: Icon(Icons.delete)
                              ),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  context.read<BasketBloc>().add(RemoveItem(state.basket.itemQuantity(state.basket.items).keys.elementAt(index)));
                                },
                                icon: Icon(Icons.remove_circle)
                              ),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  context.read<BasketBloc>().add(AddItem(state.basket.itemQuantity(state.basket.items).keys.elementAt(index)));
                                },
                                icon: Icon(Icons.add_circle)
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
            ],
          ),
        ));
  }
}
