import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:machine_test/main.dart';
import 'package:machine_test/models/country_model.dart';
import 'package:machine_test/presentation/country_detail_screen.dart';
import 'package:machine_test/repositories/api_repository.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  ApiRepository api = ApiRepository();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries"),
      ),
      body: body(size, context),
    );
  }

  //////////////////////////////////
  Widget body(Size size, BuildContext context) {
    return FutureBuilder(
        future: api.getCountries(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            log(snapshot.data.toString());
            MaincountryModel countries = snapshot.data['data'];
            return ListView.builder(
                shrinkWrap: true,
                itemCount: countries.countries.length,
                itemBuilder: (context, index) {
                  CountryModel country = countries.countries[index];
                  return ListTile(
                    onTap: () {
                      navigatorKey.currentState?.push(MaterialPageRoute(
                          builder: (_) => CountryDetailScreen(id: country.id)));
                    },
                    title: Text(country.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18)),
                    subtitle: Text(
                        "Mobile code :" + country.mobileCode.toString(),
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                            fontSize: 15)),
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
