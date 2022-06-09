import 'package:equatable/equatable.dart';

class Voucher extends Equatable {
  final int id;
  final String code;
  final double value;

  Voucher({
    required this.id, 
    required this.code, 
    required this.value
  });

  @override
  List<Object?> get props => [id, code, value];
  
  static List<Voucher> vouchers = [
    Voucher(id: 1, code: "SAVE500", value: 500.00),
    Voucher(id: 2, code: "SAVE1000", value: 1000.00),
    Voucher(id: 3, code: "SAVE1500", value: 1500.00),
  ];
}