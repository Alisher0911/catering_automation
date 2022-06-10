import 'package:catering/config/text_styles.dart';
import 'package:catering/models/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

class AddCreditCardScreen extends StatefulWidget {
  static const String routeName = '/add-credit-card';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => AddCreditCardScreen(), settings: RouteSettings(name: routeName));
  }

  const AddCreditCardScreen({ Key? key }) : super(key: key);

  @override
  State<AddCreditCardScreen> createState() => _AddCreditCardScreenState();
}

class _AddCreditCardScreenState extends State<AddCreditCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                  "Добавить карту",
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
                      if (formKey.currentState!.validate()) {
                        PaymentCard.paymentCards.add(PaymentCard(cardNumber: cardNumber, cardHolderName: cardHolderName, expiryDate: expiryDate));
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              content: Text(
                                "Ваша кредитная карта была добавлена",
                                style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.normal),
                              ),
                              actions: [
                                Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: KPrimaryColor,
                                    ), 
                                    child: Text(
                                      "OK",
                                      style: TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop();
                                      Navigator.of(context).pop();
                                    }
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        print('invalid!');
                      }
                    },
                    child: Text(
                      "Добавить",
                      style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
                    )
                  ),
                )
              ],
            ),
          ),
        ),

      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardBgColor: Colors.amber,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                onCreditCardWidgetChange: (CreditCardBrand ) {  },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CreditCardForm(
                        textColor: Colors.white,
                        formKey: formKey,
                        onCreditCardModelChange: onCreditCardModelChange,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumberDecoration: const InputDecoration(
                          contentPadding:EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.white
                            )
                          ),
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white30)
                        ),
                        expiryDateDecoration: const InputDecoration(
                          contentPadding:EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.white
                            )
                          ),
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white30)
                        ),
                        cvvCodeDecoration: const InputDecoration(
                          contentPadding:EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.white
                            )
                          ),
                          labelText: 'CVV',
                          hintText: 'XXX',
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white30)
                        ),
                        cardHolderDecoration: const InputDecoration(
                          contentPadding:EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.white
                            )
                          ),
                          labelText: 'Card Holder Name',
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white30)
                        ), cardHolderName: '', cardNumber: '', cvvCode: '', expiryDate: '', themeColor: Colors.amber,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }


  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}