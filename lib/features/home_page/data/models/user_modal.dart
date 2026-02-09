import 'package:river_pod_practise/features/home_page/domain/entities/user.dart';
import 'package:river_pod_practise/features/home_page/data/models/address_modal.dart';
import 'package:river_pod_practise/features/home_page/data/models/company_modal.dart';

class UserModal extends User {
  UserModal({
    required super.id,
    required super.name,
    required super.username,
    required super.email,
    required super.address,
    required super.phone,
    required super.website,
    required super.company,
  });

  factory UserModal.fromJson(Map<String, dynamic> json) {
    return UserModal(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: AddressModal.fromJson(json['address']),
      phone: json['phone'],
      website: json['website'],
      company: CompanyModal.fromJson(json['company']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'email': email,
    'phone': phone,
    'website': website,
    'address': (address as AddressModal).toJson(),
    'company': (company as CompanyModal).toJson(),
  };
}
