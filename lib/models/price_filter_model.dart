import 'package:catering/models/price_model.dart';
import 'package:equatable/equatable.dart';

class PriceFilter extends Equatable {
  final int id;
  final Price price;
  final bool value;

  PriceFilter({ required this.id, required this.price, required this.value});

  PriceFilter copyWith ({
    int? id,
    Price? price,
    bool? value
  }) {
    return PriceFilter(id: id ?? this.id, price: price ?? this.price, value: value ?? this.value);
  }

  @override
  List<Object?> get props => [id, Price, value];

  static List<PriceFilter> filters = Price.prices
      .map((price) =>
          PriceFilter(id: price.id, price: price, value: false))
      .toList();
}