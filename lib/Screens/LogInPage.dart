import 'dart:async';

import 'package:canteen_app/Auth%20Services/AuthServices.dart';
import 'package:canteen_app/Models/CAUser.dart';
import 'package:canteen_app/Screens/AdminHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Models/Customer_Model.dart';

class LogInPage extends StatefulWidget {
  LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool? isCustomer = true;

  final AuthServices _authServices = AuthServices();

  final InputDecoration _inputdecoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)));

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Login Screen"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: _inputdecoration.copyWith(hintText: "Enter Email"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: userNameController,
                decoration:
                    _inputdecoration.copyWith(hintText: "Enter your User Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: _inputdecoration.copyWith(
                    hintText: "Enter Your Phone Number"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  controller: passwordController,
                  decoration:
                      _inputdecoration.copyWith(hintText: "Enter Password")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // CAUser? customer;
                      // Can't assign to <Customer> obj coz we don't know whether the
                      //person logged in was a Customer or a Admin
                      try {
                        await _authServices
                            .createCustomerUsingEmailAndPassword(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                userNameController.text.trim(),
                                phoneNumberController.text.trim(),
                                isCustomer);
                      } on Exception catch (e) {
                        // TODO
                        print(e);
                      }

                      // if (customer == null) {
                      //   print("Error Logging in !!");
                      // } else {
                      //   // Navigator.push(
                      //   //     context,
                      //   //     MaterialPageRoute(
                      //   //         builder: (context) =>
                      //   //             AdminHomePage(caUser: customer)));
                      //   print("Signed in successfully");
                      // }
                    },
                    child: const Text("Sign in"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final customer;
                      // Can't assign to <Customer> obj coz we don't know whether the
                      //person logged in was a Customer or a Admin
                      try {
                         await _authServices
                            .logInCustomerUsingEmailAndPassword(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          userNameController.text.trim(),
                          phoneNumberController.text.trim(),
                        );
                      } on Exception catch (e) {
                        // TODO
                        print(e);
                      }

                      // if (customer == null) {
                      //   print("Error Logging in !!");
                      // } else {
                      //   // Navigator.push(
                      //   //     context,
                      //   //     MaterialPageRoute(
                      //   //         builder: (context) =>
                      //   //             AdminHomePage(caUser: customer)));
                      //   print("Signed in successfully");
                      // }
                    },
                    child: const Text("log in"),
                  ),
                  TextButton(
                    onPressed: () => null,
                    child: const Text("Forgot Password?"),
                  )
                ],
              ),
              CheckboxListTile(
                  secondary: Text("Are You a Customer ?"),
                  value: isCustomer,
                  onChanged: (value) {
                    setState(() {
                      isCustomer = value;
                    });
                    print("isCustomer = $isCustomer");
                  })
            ],
          ),
        ),
      ),
    ));
  }
}
