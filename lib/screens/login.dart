import 'dart:async';

import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/screens/EnterOTP.dart';
import 'package:maraka/screens/Registration.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/screens/forgotPassword.dart';
import 'package:maraka/screens/home.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isobscure = true;
  String _errorMessage = "";
  bool _loading = false;
  final _loader = const SpinKitFoldingCube(
    color: MyColors.blue3,
    size: 80,
    // duration: Duration(milliseconds: 1000),
  );
  // ignore: prefer_typing_uninitialized_variables
  var user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(builder: (context, constraints) {
        print(constraints);
        return Stack(
          children: <Widget>[
            CustomPaint(
              painter: BackgroundDesign(),
              child: Container(),
            ),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
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
                            MediaQuery.of(context).copyWith().size.height * 0.3,
                        width:
                            MediaQuery.of(context).copyWith().size.width * 0.6,
                        child: Image.asset(
                          "assets/maraka.png",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).copyWith().size.width *
                              0.1),
                      child: SizedBox(
                        width:
                            MediaQuery.of(context).copyWith().size.width * 0.8,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: "Enter Your Email Address",
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: MyColors.brown2,
                            ),
                            labelStyle: TextStyle(color: MyColors.brown3),
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Email Address is empty";
                            } else if (!EmailValidator.validate(value.trim())) {
                              return "Invalid Email Format";
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
                              0.1),
                      child: SizedBox(
                        width:
                            MediaQuery.of(context).copyWith().size.width * 0.8,
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _isobscure,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock_outline,
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
                            labelStyle: const TextStyle(color: MyColors.brown3),
                            border: const UnderlineInputBorder(),
                            labelText: 'Password',
                          ),
                          validator: (String? value) {
                            return value == null || value.trim().isEmpty
                                ? 'Password Cannot be empty'
                                : null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).copyWith().size.width *
                              0.3,
                          top: MediaQuery.of(context).copyWith().size.height *
                              0.01),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(color: MyColors.red1),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).copyWith().size.width *
                                0.3,
                            top: MediaQuery.of(context).copyWith().size.height *
                                0.01),
                        child: Container(
                          width: MediaQuery.of(context).copyWith().size.width *
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
                              if (_formKey.currentState!.validate()) {
                                user = User(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim());
                                // CircularProgressIndicator();
                                setState(() {
                                  _loading = true;
                                });
                                try {
                                  await user.login().timeout(
                                      const Duration(seconds: 25),
                                      onTimeout: () => throw TimeoutException(
                                          'Can\'t connect to internet'));
                                  setState(() {
                                    _errorMessage = "";
                                    _loading = false;
                                  });
                                  if (user.response.statusCode != null) {
                                    if (user.response.statusCode == 200) {
                                      if (user.is_confirmed) {
                                        // print(user.is_confirmed);
                                        // ignore: use_build_context_synchronously
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home(
                                                      currentIndex: 0,
                                                      user: user,
                                                    )));
                                      } else {
                                        _errorMessage =
                                            "Your Account is not validated";
                                        // ignore: use_build_context_synchronously
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => OTP(
                                                    user: user,
                                                    isRegister: true)));
                                        // user = null;
                                      }
                                    } else {
                                      setState(() {
                                        user = null;
                                        _errorMessage = "Invalid credentials";
                                      });
                                    }
                                  }
                                } catch (error) {
                                  // ignore: avoid_print

                                  setState(() {
                                    _errorMessage =
                                        "Opps looks like there is no internet";
                                    _loading = false;
                                    user = null;
                                  });
                                } finally {}
                              }
                            },
                            child: const Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).copyWith().size.width *
                              0.1,
                          top: MediaQuery.of(context).copyWith().size.height *
                              0.01),
                      child: Row(
                        children: <Widget>[
                          const Text(
                            "Don't Have an Account?",
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
                                "Sign up",
                                style: TextStyle(
                                  color: MyColors.blue3,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Registration()));
                              },
                            ),
                          ),
                          if (constraints.maxWidth >= 600)
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width *
                                      0.01),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()));
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: MyColors.blue3),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (constraints.maxWidth < 600)
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).copyWith().size.width *
                                0.33),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: MyColors.blue3),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (_loading)
              Container(
                width: MediaQuery.of(context).copyWith().size.width,
                height: MediaQuery.of(context).copyWith().size.height,
                color: Colors.white.withOpacity(0.8),
                child: Center(
                  child: _loader,
                ),
              ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        maintainState: false,
                        builder: (context) => Home(
                              currentIndex: 0,
                              user: user ?? User(),
                            )));
              },
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).copyWith().size.height * 0.07,
                  left: MediaQuery.of(context).copyWith().size.width * 0.02,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: MyColors.blue3,
                  size: 30,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
