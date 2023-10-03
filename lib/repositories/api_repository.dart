import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:machine_test/models/country_model.dart';
import 'package:machine_test/repositories/url_repository.dart';

import '../models/login_model.dart';

class ApiRepository {
  UrlRepository urlRep = UrlRepository();
  //////////////////////////////////////////////// login
  loginCheck(LoginModel login) async {
    try {
      var response =
          await http.post(Uri.parse(urlRep.loginUrl), body: login.toJson());
      log(response.body.toString(), name: "response body123");

      if (response.statusCode == 01) {
        log(response.body.toString(), name: "response body");
        var body = jsonDecode(response.body);
        log(body.toString(), name: "body");
        if (body['message'] == "Login Success") {
          // UserModel userDetails = userModelFromJson(response.body);
          return {
            "status": "authSuccess",
          };
        } else {
          return {"status": "authFailed", "error": "wrong credentials"};
        }
      } else {
        var body = jsonDecode(response.body);

        return {"status": "failed", "error": body["message"]};
      }
    } on SocketException {
      return {"status": "failed", "error": "network error"};
    } catch (e) {
      log(e.toString(), name: "sina");
      return {"status": "failed", "error": "client error"};
    }
  }

  ////////////////////////////////////////// countries
  getCountries() async {
    try {
      var response = await http.get(
          Uri.parse(
            urlRep.getCountriesUrl,
          ),
          headers: {
            "Token": "Bearer 1|GSOBRFb1MWjV8cpioTslA7jCO4uvkYL6zNkTcYR4"
          });
      var body = jsonDecode(response.body);
      MaincountryModel countries = MaincountryModel.fromJson(body);
      log(response.body.toString(), name: "response body123");
      return {"status": "success", "data": countries};
    } on SocketException {
      return {"status": "failed", "error": "network error"};
    } catch (e) {
      log(e.toString(), name: "sina");
      return {"status": "failed", "error": "client error"};
    }
  }

  ////////////////////////////////////////// states
  getStates() async {
    try {
      var response = await http.get(
          Uri.parse(
            urlRep.getStatesUrl,
          ),
          headers: {
            "Token": "Bearer 1|GSOBRFb1MWjV8cpioTslA7jCO4uvkYL6zNkTcYR4"
          });
      var body = jsonDecode(response.body);
      MaincountryModel countries = MaincountryModel.fromJson(body);
      log(response.body.toString(), name: "response body123");
      return {"status": "success", "data": countries};
    } on SocketException {
      return {"status": "failed", "error": "network error"};
    } catch (e) {
      log(e.toString(), name: "sina");
      return {"status": "failed", "error": "client error"};
    }
  }
}
