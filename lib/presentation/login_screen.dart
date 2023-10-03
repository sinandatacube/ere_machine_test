import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:machine_test/logic/login/login_bloc.dart';
import 'package:machine_test/main.dart';
import 'package:machine_test/models/login_model.dart';
import 'package:machine_test/presentation/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  ValueNotifier<bool> isObscure = ValueNotifier(true);
  LoginBloc bloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: body(size, context),
      bottomNavigationBar: bottom(size, context),
    );
  }

  Widget body(Size size, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            // height: 400,
            width: size.width,
            color: const Color.fromARGB(0, 32, 31, 31),
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.25,
                ),
                const Text(
                  "Welcome\nback to",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "CrowdAfrick",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          // bottom(size, context),
        ],
      ),
    );
  }

///////////////////////////////////////////////////////
  Widget bottom(Size size, BuildContext context) {
    return Container(
      // height: 350,
      padding: EdgeInsets.only(
          right: size.width * 0.06,
          left: size.width * 0.06,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      width: size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Sign in",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: phoneCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter your phone number",
              hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
              contentPadding: const EdgeInsets.all(4),
              // isCollapsed: true,
              fillColor: Colors.red.shade500,
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(10)),
              // border: OutlineInputBorder(
              //   borderSide: BorderSide(color: Colors.grey[400]!),
              //   borderRadius: BorderRadius.circular(10),
              // ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ValueListenableBuilder(
              valueListenable: isObscure,
              builder: (context, value, child) {
                return TextField(
                  controller: passwordCtrl,
                  obscureText: value,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    suffixIcon: IconButton(
                      onPressed: () {
                        isObscure.value = !isObscure.value;
                      },
                      icon: Icon(value
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_rounded),
                      color: Colors.grey.shade400,
                    ),
                    contentPadding: const EdgeInsets.all(4),
                    // isCollapsed: true,
                    fillColor: Colors.red.shade500,
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(10)),
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.grey[400]!),
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                  ),
                );
              }),
          Container(
            height: 50,
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.centerRight,
            child: const Text(
              "Forgot password",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          BlocConsumer<LoginBloc, LoginState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is LoginSuccess) {
                navigatorKey.currentState?.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false);
              }
              if (state is LoginFailed) {
                Fluttertoast.showToast(msg: "Enter valid credentials");
              }

              if (state is LoginError) {
                Fluttertoast.showToast(msg: state.error);
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade500,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      fixedSize: Size(size.width * 0.9, 45)),
                  onPressed: () => submitLogin(),
                  child: state is LoginChecking
                      ? const CupertinoActivityIndicator(
                          color: Colors.white,
                        )
                      : const Text("Login"));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Dont have an account yet?",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                  fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Text(
                "Sign up",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.red.shade700,
                    fontSize: 15),
              ),
            )
          ]),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

// \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/////////////////////////////////////
  submitLogin() {
    String phone = phoneCtrl.text.trim();
    String password = phoneCtrl.text.trim();
    if (phone.length != 10) {
      Fluttertoast.showToast(msg: "Enter valid phone number");
    } else if (password.length < 6) {
      Fluttertoast.showToast(msg: "Enter valid password");
    } else {
      String device = getDeviceInfo();
      LoginModel login =
          LoginModel(password: password, phone: "91$phone", device: device);
      bloc.add(CheckLogin(login: login));
    }
  }

//////////////////////////////////////////////////////
  String getDeviceInfo() {
    String platform;
    if (Platform.isAndroid) {
      platform = "Android";
    } else if (Platform.isIOS) {
      platform = "IOS";
    } else {
      platform = "web";
    }
    return platform;
  }
}
