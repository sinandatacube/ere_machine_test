import 'dart:convert';

class MaincountryModel {
  List<CountryModel> countries;

  MaincountryModel({
    required this.countries,
  });

  factory MaincountryModel.fromJson(Map<dynamic, dynamic> json) =>
      MaincountryModel(
        countries: List<CountryModel>.from(
            json["countries"].map((x) => CountryModel.fromJson(x))),
      );
}

class CountryModel {
  int id;
  String name;
  String code;
  int mobileCode;

  CountryModel({
    required this.id,
    required this.name,
    required this.code,
    required this.mobileCode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        mobileCode: json["mobile_code"],
      );
}
