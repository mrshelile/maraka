import 'dart:async';
import 'dart:convert';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/screens/EnterOTP.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/screens/home.dart';
import 'package:maraka/screens/login.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:email_validator/email_validator.dart';

class Registration extends StatefulWidget {
  Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _fullNamesController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  bool _isobscure = true;
  var _errorMessage = "";
  bool _loading = false;
  final _loader = SpinKitFoldingCube(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).copyWith().size.width * 0.05,
                        top: MediaQuery.of(context).copyWith().size.height *
                            0.2),
                    child: Container(
                      height:
                          MediaQuery.of(context).copyWith().size.height * 0.3,
                      width: MediaQuery.of(context).copyWith().size.width * 0.6,
                      child: SvgPicture.asset("assets/forms.svg",
                          semanticsLabel: "forms Image"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).copyWith().size.width * 0.1),
                    child: SizedBox(
                      width: MediaQuery.of(context).copyWith().size.width * 0.8,
                      child: TextFormField(
                        controller: _fullNamesController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_outline_outlined,
                            color: MyColors.brown2,
                          ),
                          labelStyle: TextStyle(color: MyColors.brown3),
                          border: UnderlineInputBorder(),
                          labelText: 'Full Names',
                        ),
                        validator: (String? value) {
                          return value == null || value.isEmpty
                              ? 'Enter Your Full Names'
                              : null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).copyWith().size.width * 0.1),
                    child: Container(
                      width: MediaQuery.of(context).copyWith().size.width * 0.8,
                      child: TextFormField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
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
                          // String pattern =
                          //     r"^[a-zA-Z0-9.!#$%&'*+/?^_`{|}`-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                          //     r"{0,253}[a-zA-Z0])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9]"
                          //     r"{0,253}[a-zA-Z0])?)*$";
                          // RegExp regex = new RegExp(pattern);
                          // if (!regex.hasMatch(value!) &&
                          //     // ignore: unnecessary_null_comparison
                          //     value != null &&
                          //     value.isNotEmpty)
                          //   return "Invalid Email Format";
                          // else if (value == null || value.isEmpty)
                          //   return 'Email Address Cannot be empty';
                          // else
                          //   return null;
                          if (value == null || value.isEmpty)
                            return "Email Address is empty";
                          else if (!EmailValidator.validate(value))
                            return "Invalid Email Format";
                          else
                            return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).copyWith().size.width * 0.1),
                    child: Container(
                      width: MediaQuery.of(context).copyWith().size.width * 0.8,
                      child: TextFormField(
                        controller: _phoneNumberController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone_android_outlined,
                            color: MyColors.brown2,
                          ),
                          labelStyle: TextStyle(color: MyColors.brown3),
                          border: UnderlineInputBorder(),
                          labelText: 'Phone Number',
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (String? value) {
                          return value == null || value.isEmpty
                              ? 'Phone Number Cannot be empty'
                              : null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).copyWith().size.width * 0.1),
                    child: Container(
                      width: MediaQuery.of(context).copyWith().size.width * 0.8,
                      child: TextFormField(
                        controller: _passwordController,
                        textInputAction: TextInputAction.next,
                        obscureText: _isobscure,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
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
                          labelStyle: TextStyle(color: MyColors.brown3),
                          border: UnderlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (String? value) {
                          // bool passValid = RegExp(
                          //         "^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z](?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*")
                          //     .hasMatch(value!);

                          // if (value.isEmpty && !passValid)
                          //   return 'Password strength is to weak';
                          return value == null || value.isEmpty
                              ? 'Password Cannot be empty'
                              : null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).copyWith().size.width * 0.1),
                    child: Container(
                      width: MediaQuery.of(context).copyWith().size.width * 0.8,
                      child: TextFormField(
                        controller: _rePasswordController,
                        textInputAction: TextInputAction.next,
                        obscureText: _isobscure,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
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
                          labelStyle: TextStyle(color: MyColors.brown3),
                          border: UnderlineInputBorder(),
                          labelText: 'Confirm Password',
                        ),
                        validator: (String? value) {
                          return value == null || value.isEmpty
                              ? 'Password Cannot be empty'
                              : null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).copyWith().size.width * 0.25,
                        top: MediaQuery.of(context).copyWith().size.height *
                            0.01),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(color: MyColors.red1),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).copyWith().size.width *
                              0.3,
                          top: MediaQuery.of(context).copyWith().size.height *
                              0.01),
                      child: Container(
                        width:
                            MediaQuery.of(context).copyWith().size.width * 0.35,
                        decoration: BoxDecoration(
                            color: MyColors.blue3,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 5))
                            ],
                            border: Border.all(color: MyColors.blue2),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () async {
                            User user = new User();
                            if (_formKey.currentState!.validate()) {
                              if (_passwordController.text
                                  .endsWith(_rePasswordController.text)) {
                                // int phone1 = int.parse(_phoneNumberController.text);
                                User user = User(
                                    name: _fullNamesController.text,
                                    email: _emailController.text,
                                    phone1:
                                        int.parse(_phoneNumberController.text),
                                    password: _passwordController.text);
                                setState(() {
                                  _loading = true;
                                });
                                try {
                                  await user.register().timeout(
                                      const Duration(seconds: 25),
                                      onTimeout: () => throw TimeoutException(
                                          'Can\'t connect to internet'));
                                  setState(() {
                                    _errorMessage = "";
                                    _loading = false;
                                  });
                                  if (user.response.statusCode != null) {
                                    if (user.response.statusCode == 400) {
                                      setState(() {
                                        _errorMessage = jsonDecode(
                                                user.response.body)['error']
                                            ['message'];
                                      });
                                    }
                                    // print(user.response.statusCode);
                                    setState(() {
                                      _loading = false;
                                    });
                                    if (user.response.statusCode == 200) {
                                      setState(() {
                                        _errorMessage = "";
                                      });
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OTP(
                                                    isRegister: true,
                                                    user: user,
                                                  )));
                                    }
                                  }
                                } catch (error) {
                                  setState(() {
                                    _errorMessage =
                                        "Can't connect to internet";
                                    _loading = false;
                                  });
                                } finally {}
                              } else {
                                _errorMessage = "Password does not match";
                              }
                            }
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).copyWith().size.width * 0.25,
                        top: MediaQuery.of(context).copyWith().size.height *
                            0.01),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Have An Account?",
                          style: TextStyle(color: MyColors.brown3),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left:
                                  MediaQuery.of(context).copyWith().size.width *
                                      0.01),
                          child: TextButton(
                            child: Text(
                              "Login",
                              style: TextStyle(color: MyColors.blue3),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                          ),
                        )
                      ],
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
        ],
      ),
    );
  }
}
