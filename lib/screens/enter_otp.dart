import 'package:get/get.dart';
import 'package:maraka/logic/email.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/screens/update_password.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/screens/login.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class OTP extends StatefulWidget {
  User user;
  bool isRegister;
  OTP({super.key, required this.user, required this.isRegister});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  var _errorMessage = "";
  final String _buttonText = "Verify";
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
                  Column(
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
                          child: SvgPicture.asset("assets/security.svg",
                              semanticsLabel: "Security Image"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).copyWith().size.width *
                                0.1),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: const Text("Check email for OTP code"),
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
                            controller: _otpController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.security_outlined,
                                color: MyColors.brown2,
                              ),
                              labelStyle: TextStyle(color: MyColors.brown3),
                              border: UnderlineInputBorder(),
                              labelText: 'Enter OTP Code',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              return value == null || value.isEmpty
                                  ? 'OTP Code cannot be empty'
                                  : null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left:
                            MediaQuery.of(context).copyWith().size.width * 0.3,
                        top: MediaQuery.of(context).copyWith().size.height *
                            0.01),
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).copyWith().size.width *
                              0.3,
                          top: MediaQuery.of(context).copyWith().size.height *
                              0.04),
                      child: Container(
                        width:
                            MediaQuery.of(context).copyWith().size.width * 0.35,
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
                              await verifyOTP(
                                  widget.user, _otpController.text.trim());

                              if (widget.isRegister && isvalid) {
                                var res = await validateAcc(widget.user);
                                if (res.statusCode == 200) {
                                  Get.off(() => const Login());
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Login()));
                                }
                              } else {
                                // ignore: duplicate_ignore
                                if (isvalid) {
                                  setState(() {
                                    _errorMessage = "";
                                  });

                                  Get.off(() => UpdatePassword(
                                        user: widget.user,
                                        otp: _otpController.text.trim(),
                                      ));

                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => UpdatePassword(
                                  //               user: widget.user,
                                  //               otp: _otpController.text.trim(),
                                  //             )));
                                } else {
                                  setState(() {
                                    _errorMessage = "OTP is incorrect";
                                  });
                                }
                              }
                            }
                          },
                          child: Text(
                            _buttonText,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
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
                        const Text(
                          "Back To Login",
                          style: TextStyle(color: MyColors.brown3),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left:
                                  MediaQuery.of(context).copyWith().size.width *
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
            ),
          ),
        ],
      ),
    );
  }
}
