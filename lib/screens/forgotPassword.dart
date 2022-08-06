import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/screens/EnterOTP.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/screens/login.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

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
                      child: SvgPicture.asset("assets/update.svg",
                          semanticsLabel: "update Image"),
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
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(value!) &&
                              value != null &&
                              value.isNotEmpty)
                            return "Invalid Email Format";
                          else if (value == null || value.isEmpty)
                            return 'Email Address Cannot be empty';
                          else
                            return null;
                        },
                      ),
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
                                  color: Colors.grey.withOpacity(0.6),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 5))
                            ],
                            border: Border.all(color: MyColors.blue2),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              User tempUser =
                                  User(email: _emailController.text);
                              await tempUser.resetPassword();
                              if (tempUser.canUpdatePassword) {
                                print(tempUser.canUpdatePassword);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OTP(
                                              user: tempUser,
                                              isRegister: false,
                                            )));
                              }
                            }
                          },
                          child: Text(
                            "Reset",
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
                          "Back To Login",
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
        ],
      ),
    );
  }
}
