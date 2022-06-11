import 'package:equatable/equatable.dart';

class OrgType extends Equatable {
  final int id;
  final String type;

  OrgType({
    required this.id,
    required this.type,
  });

  @override
  List<Object?> get props => [id, type];

  static List<OrgType> orgTypes = [
    OrgType(id: 1, type: "Restaurant"),
    OrgType(id: 2, type: "Cafe"),
    OrgType(id: 3, type: "Bar"),
    OrgType(id: 4, type: "Grill-Bar"),
    OrgType(id: 5, type: "Fast Food"),
  ];
}