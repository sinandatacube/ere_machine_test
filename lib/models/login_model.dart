// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

// LoginModel userModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String userModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String phone;
  String password;
  String device;

  LoginModel({
    required this.phone,
    required this.password,
    required this.device,
  });

  // factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
  //       id: json["id"],
  //       entryDate: json["entry_date"] ?? "",
  //       companyName: json["company_name"],
  //       address: json["address"],
  //       mobile: json["mobile"],
  //       password: json["password"],
  //       email: json["email"] ?? "",
  //       website: json["website"] ?? "",
  //       gstNumber: json["gst_number"] ?? "",
  //       promoCode: json["promo_code"] ?? "",
  //       opTime: json["op_time"] ?? "",
  //       clTime: json["cl_time"] ?? "",
  //       vhType: json["vh_type"] ?? "",
  //       vhCat: json["vh_cat"] ?? "",
  //       companyLogo: json["company_logo"] ?? "",
  //       showroomLatitude: json["showroom_latitude"],
  //       showroomLongitude: json["showroom_longitude"],
  //       privilege: json["privilege"] ?? "",
  //     );

  Map<String, dynamic> toJson() => {
        "phone_number": phone,
        "password": password,
        "device_type": device,
      };
}
