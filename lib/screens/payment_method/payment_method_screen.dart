import 'package:catering/config/text_styles.dart';
import 'package:catering/models/payment_card.dart';
import 'package:catering/screens/payment_method/add_credit_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class PaymentMethodScreen extends StatefulWidget {
  static const String routeName = '/payment-method';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => PaymentMethodScreen(), settings: RouteSettings(name: routeName));
  }

  const PaymentMethodScreen({ Key? key }) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}


class _PaymentMethodScreenState extends State<PaymentMethodScreen> {

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
                  "Способы оплаты",
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
                        settings: RouteSettings(name: AddCreditCardScreen.routeName),
                        screen: AddCreditCardScreen(),
                        withNavBar: true,
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      ).then((_) {
                        setState(() {
                        });
                      });
                    },
                    child: Text(
                      "Добавить карту",
                      style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
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
              Text('Кредитные карты',
                style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white)
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: PaymentCard.paymentCards.length,
                itemBuilder: ((context, index) {
                  return Dismissible(
                    key: ValueKey(PaymentCard.paymentCards[index].cardNumber),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.redAccent,
                      child: Icon(Icons.delete, color: Colors.white),
                      padding: EdgeInsets.only(right: 30),
                      margin: EdgeInsets.all(5),
                    ),
                    confirmDismiss: (direction) {
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Подтвердите"),
                          content: Text("Вы действительно хотите удалить кредитную карту?"),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: KPrimaryColor,
                              ), 
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                              child: Text("Отмена")
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: KPrimaryColor,
                              ), 
                              onPressed: () {
                                Navigator.of(ctx).pop(true);
                              },
                              child: Text("Удалить")
                            ),
                          ],
                        )
                      );
                    },
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        PaymentCard.paymentCards.removeAt(index);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
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
                        ],
                      ),
                    ),
                  );
                })
              )
            ],
          ),
        ),
      )
    );
  }
}