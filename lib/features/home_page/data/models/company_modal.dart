import 'package:river_pod_practise/features/home_page/domain/entities/user.dart';

class CompanyModal extends Company {
  CompanyModal({
    required super.name,
    required super.catchPhrase,
    required super.bs,
  });

  factory CompanyModal.fromJson(Map<String, dynamic> json) {
    return CompanyModal(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'catchPhrase': catchPhrase,
    'bs': bs,
  };
}
