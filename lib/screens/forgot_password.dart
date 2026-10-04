import 'dart:async';

import 'package:maraka/widgets/compat_loading.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/screens/login.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'enter_otp.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String _errorMessage = '';
  bool _loading = false;
  final _loader = const SpinKitFoldingCube(
    color: MyColors.blue3,
    size: 80,
    // duration: Duration(milliseconds: 1000),
  );
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
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).copyWith().size.width *
                                0.05,
                            top: MediaQuery.of(context).copyWith().size.height *
                                0.2),
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).copyWith().size.height *
                                  0.3,
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.6,
                          child: SvgPicture.asset("assets/update.svg",
                              semanticsLabel: "update Image"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).copyWith().size.width *
                                0.1),
                        child: SizedBox(
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.8,
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: MyColors.brown2,
                              ),
                              labelStyle: TextStyle(color: MyColors.brown3),
                              border: UnderlineInputBorder(),
                              labelText: 'Enter your email',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? value) {
                              String pattern =
                                  r"^[a-zA-Z0-9.!#$%&'*+/?^_`{|}`-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9]"
                                  r"{0,253}[a-zA-Z0])?)*$";
                              RegExp regex = RegExp(pattern);
                              if (!regex.hasMatch(value!.trim()) &&
                                  value.trim().isNotEmpty) {
                                return "Invalid Email Format";
                              } else if (value.trim().isEmpty) {
                                return 'Email Address Cannot be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).copyWith().size.width *
                                0.1,
                            top: MediaQuery.of(context).copyWith().size.height *
                                0.01),
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(color: MyColors.red1),
                        ),
                      ),
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
                                      color: Colors.grey.withOpacity( 0.6),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5))
                                ],
                                border: Border.all(color: MyColors.blue2),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  User? tempUser =
                                      User(email: _emailController.text.trim());
                                  setState(() {
                                    _loading = true;
                                  });
                                  try {
                                    await tempUser.resetPassword().timeout(
                                        const Duration(seconds: 20),
                                        onTimeout: () => throw TimeoutException(
                                            'Can\'t send email'));
                                    if (tempUser.canUpdatePassword) {
                                      setState(() {
                                        _errorMessage = "";
                                        _loading = false;
                                      });
                                      // ignore: avoid_print
                                      print(tempUser.canUpdatePassword);

                                      Get.off(() => OTP(
                                            user: tempUser!,
                                            isRegister: false,
                                          ));
                                      // Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => OTP(
                                      //               user: tempUser!,
                                      //               isRegister: false,
                                      //             )));
                                    } else {
                                      setState(() {
                                        _errorMessage = "email does not exist";
                                        _loading = false;
                                      });
                                    }
                                  } catch (error) {
                                    setState(() {
                                      _errorMessage =
                                          "failed!! check if your email is correct";
                                      _loading = false;

                                      tempUser = null;
                                    });
                                  }
                                }
                              },
                              child: const Text(
                                "Reset",
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
                      color: Colors.white.withOpacity( 0.92),
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
