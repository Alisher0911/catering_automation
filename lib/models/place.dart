import 'package:catering/models/local_organization.dart';
import 'package:geocoding/geocoding.dart';

class Place {
  final LocalOrganization localOrganization;
  final Location location;

  Place({
    required this.localOrganization,
    required this.location
  });
}