import 'package:river_pod_practise/features/home_page/domain/entities/user.dart';
import 'package:river_pod_practise/features/home_page/data/models/geo_modal.dart';

class AddressModal extends Address {
  AddressModal({
    required super.street,
    required super.suite,
    required super.city,
    required super.zipcode,
    required super.geo,
  });

  factory AddressModal.fromJson(Map<String, dynamic> json) {
    return AddressModal(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
      geo: GeoModal.fromJson(json['geo']),
    );
  }

  Map<String, dynamic> toJson() => {
    'street': street,
    'suite': suite,
    'city': city,
    'zipcode': zipcode,
    'geo': (geo as GeoModal).toJson(),
  };
}
