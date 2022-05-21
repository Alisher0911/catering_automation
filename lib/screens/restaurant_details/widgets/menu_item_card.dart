import 'package:catering/bloc/basket/basket_bloc.dart';
import 'package:catering/bloc/menu_item_quantity/menuitemquantity_cubit.dart';
import 'package:catering/config/text_styles.dart';
import 'package:catering/models/menu_item_model.dart';
import 'package:catering/screens/restaurant_details/widgets/glassmorphism.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem menuItem;

  const MenuItemCard({Key? key, required this.menuItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showMenuItemDetails(context, menuItem);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          // change
                          image: NetworkImage(
                              "https://images.pexels.com/photos/6267/menu-restaurant-vintage-table.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                          fit: BoxFit.cover)),
                ),

                Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      width: 60,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "\$${menuItem.price}",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Color(0xFFFE724C)),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    right: 10,
                    child: Glassmorphism(
                      blur: 5,
                      opacity: 0.1,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            onPressed: () {
                            },
                            // iconSize: 16,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: Icon(
                              CupertinoIcons.heart_fill,
                              color: Colors.white,
                            )),
                      ),
                    )
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menuItem.name,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 5),
                  Text(
                    menuItem.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Color(0xFF9796A1)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  void _showMenuItemDetails(context, menuItem) {
    showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        builder: (BuildContext bc) {
          return FractionallySizedBox(
            heightFactor: 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/6267/menu-restaurant-vintage-table.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                        top: 20,
                        right: 20,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(15)),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(bc).pop();
                            },
                            icon: Icon(
                              CupertinoIcons.xmark,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(menuItem.name,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: Colors.white)),
                        trailing: SizedBox(
                          width: 150,
                          child: BlocBuilder<MenuItemQuantityCubit,
                              MenuItemQuantityState>(
                            builder: (context, state) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(0.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: state.quantity == 1
                                          ? Colors.grey
                                          : KPrimaryColor,
                                    ),
                                    child: IconButton(
                                        onPressed: () {
                                          BlocProvider.of<
                                                      MenuItemQuantityCubit>(
                                                  context)
                                              .decrement();
                                        },
                                        iconSize: 24,
                                        constraints: BoxConstraints(),
                                        icon: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        )),
                                  ),
                                  SizedBox(width: 10),
                                  Text("${state.quantity}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(color: Colors.white)),
                                  SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(0.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: KPrimaryColor),
                                    child: IconButton(
                                        onPressed: () {
                                          BlocProvider.of<
                                                      MenuItemQuantityCubit>(
                                                  context)
                                              .increment();
                                        },
                                        iconSize: 24,
                                        constraints: BoxConstraints(),
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text("\$${menuItem.price}",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white)),
                      SizedBox(height: 10),
                      Text(menuItem.description,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white)),
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: BlocBuilder<MenuItemQuantityCubit, MenuItemQuantityState>(
                        builder: (context, state) {
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: KPrimaryColor,
                                  minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  )),
                              onPressed: () {
                                Navigator.of(context).pop();
                                context.read<MenuItemQuantityCubit>().refreshQuantity();
                                for (int i = 0; i < state.quantity; i++) {
                                  context.read<BasketBloc>().add(AddItem(menuItem));
                                }
                              },
                              child: Text(
                                "Добавить в корзину \$${(menuItem.price * state.quantity).toStringAsFixed(2)}",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: Colors.white),
                              ));
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
