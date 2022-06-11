import 'package:equatable/equatable.dart';

class PaymentCard extends Equatable {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String image;

  const PaymentCard({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    this.image = "assets/payment/mastercard.png"
  });

  @override
  List<Object?> get props => [cardNumber, cardHolderName, expiryDate, image];

  static List<PaymentCard> paymentCards = [
    PaymentCard(cardNumber: "1111222233334444", cardHolderName: "Alisher Orazbay", expiryDate: "01/22", image: "assets/payment/mastercard.png"),
  ];
}