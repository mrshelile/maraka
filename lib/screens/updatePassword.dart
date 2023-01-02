// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/screens/login.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class UpdatePassword extends StatefulWidget {
  User user;
  var OTP;
  UpdatePassword({Key? key, required this.user, required this.OTP})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _formKey = GlobalKey<FormState>();
  // final _otpController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  final _loader = const SpinKitFoldingCube(
    color: MyColors.blue3,
    size: 80,
    // duration: Duration(milliseconds: 1000),
  );
  // bool _isOTP = true;
  // ignore: non_constant_identifier_names
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool validatePassword(String pass) {
    String password = pass.trim();
    if (pass_valid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  var _errorMessage = "";
  bool _isobscure = true;
  bool _isobscure1 = true;
  // String _buttonText = "Update";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomPaint(
            painter: BackgroundDesign(),
            child: Container(),
          ),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .width *
                                    0.05,
                                top: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height *
                                    0.2),
                            child: SizedBox(
                              height: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height *
                                  0.3,
                              width:
                                  MediaQuery.of(context).copyWith().size.width *
                                      0.6,
                              child: SvgPicture.asset("assets/realtime.svg",
                                  semanticsLabel: "Real time Image"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .width *
                                    0.1),
                            child: SizedBox(
                              width:
                                  MediaQuery.of(context).copyWith().size.width *
                                      0.8,
                              child: TextFormField(
                                obscureText: _isobscure1,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: MyColors.brown2,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isobscure1
                                          ? Icons.visibility
                                          : Icons.visibility_off_outlined,
                                      color: MyColors.brown3,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isobscure1 = !_isobscure1;
                                      });
                                    },
                                  ),
                                  labelStyle:
                                      const TextStyle(color: MyColors.brown3),
                                  border: const UnderlineInputBorder(),
                                  labelText: 'Password',
                                ),
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Password Cannot Be Empty';
                                  } else {
                                    bool result =
                                        validatePassword(value.trim());
                                    if (result) {
                                      // create account event
                                      return null;
                                    } else {
                                      return "Password not strong enough (e.g Password@1)";
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .width *
                                    0.1),
                            child: SizedBox(
                              width:
                                  MediaQuery.of(context).copyWith().size.width *
                                      0.8,
                              child: TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: _isobscure,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.lock_open_outlined,
                                    color: MyColors.brown2,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isobscure
                                          ? Icons.visibility
                                          : Icons.visibility_off_outlined,
                                      color: MyColors.brown3,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isobscure = !_isobscure;
                                      });
                                    },
                                  ),
                                  labelStyle:
                                      const TextStyle(color: MyColors.brown3),
                                  border: const UnderlineInputBorder(),
                                  labelText: 'Confirm Password',
                                ),
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.trim().isEmpty) {
                                    return 'Confirm Password Cannot Be Empty';
                                  } else {
                                    bool result =
                                        validatePassword(value.trim());
                                    if (result) {
                                      // create account event
                                      return null;
                                    } else {
                                      return "Password not strong enough (e.g Password@1)";
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left:
                                  MediaQuery.of(context).copyWith().size.width *
                                      0.25,
                              top: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height *
                                  0),
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red),
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left:
                                  MediaQuery.of(context).copyWith().size.width *
                                      0.3,
                              top: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height *
                                  0.04),
                          child: Container(
                            width:
                                MediaQuery.of(context).copyWith().size.width *
                                    0.35,
                            decoration: BoxDecoration(
                                color: MyColors.blue3,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5))
                                ],
                                border: Border.all(color: MyColors.blue2),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate() &&
                                    validatePassword(
                                        _passwordController.text.trim()) &&
                                    validatePassword(_confirmPasswordController
                                        .text
                                        .trim())) {
                                  if (_passwordController.text.trim().endsWith(
                                      _confirmPasswordController.text.trim())) {
                                    setState(() {
                                      _errorMessage = "";
                                      _loading = true;
                                    });
                                    try {
                                      var res = await widget.user
                                          .updatePassword(
                                              _confirmPasswordController.text
                                                  .trim(),
                                              int.parse(widget.OTP),
                                              widget.user.email)
                                          .timeout(const Duration(seconds: 10),
                                              onTimeout: () =>
                                                  throw TimeoutException(
                                                      'Internet may not be available'));
                                      if (res.statusCode == 200) {
                                        setState(() {
                                          _errorMessage = "";
                                          _loading = false;
                                        });
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Login()));
                                      } else {
                                        setState(() {
                                          _errorMessage = "failed try again";
                                          _loading = false;
                                        });
                                      }
                                    } catch (error) {
                                      setState(() {
                                        _errorMessage =
                                            "Internet may not be available";
                                        _loading = false;
                                      });
                                    }
                                  } else
                                    // ignore: curly_braces_in_flow_control_structures
                                    setState(() {
                                      _loading = false;
                                      _errorMessage =
                                          "Passwords does not match";
                                    });

                                  // await widget.user
                                  //     .updatePassword(30, "Password@7");
                                }
                              },
                              child: const Text(
                                "Update",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).copyWith().size.width *
                                0.25,
                            top: MediaQuery.of(context).copyWith().size.height *
                                0.01),
                        child: Row(
                          children: <Widget>[
                            const Text(
                              "Back To Login",
                              style: TextStyle(color: MyColors.brown3),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width *
                                      0.01),
                              child: TextButton(
                                child: const Text(
                                  "Login",
                                  style: TextStyle(color: MyColors.blue3),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (_loading)
                    Container(
                      width: MediaQuery.of(context).copyWith().size.width,
                      height: MediaQuery.of(context).copyWith().size.height,
                      color: Colors.white.withOpacity(0.92),
                      child: Center(
                        child: _loader,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
