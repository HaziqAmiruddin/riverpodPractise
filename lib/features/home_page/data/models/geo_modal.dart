import 'package:river_pod_practise/features/home_page/domain/entities/user.dart';

class GeoModal extends Geo {
  GeoModal({required super.lat, required super.lng});

  factory GeoModal.fromJson(Map<String, dynamic> json) {
    return GeoModal(lat: json['lat'], lng: json['lng']);
  }

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}
