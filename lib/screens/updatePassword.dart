import 'package:maraka/logic/email.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/screens/login.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdatePassword extends StatefulWidget {
  User user;
  UpdatePassword({Key? key, required this.user}) : super(key: key);

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isOTP = true;
  var _errorMessage = "";
  bool _isobscure = true;
  bool _isobscure1 = true;
  String _buttonText = "Update";
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
                        child: Container(
                          height:
                              MediaQuery.of(context).copyWith().size.height *
                                  0.3,
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.6,
                          child: SvgPicture.asset("assets/realtime.svg",
                              semanticsLabel: "Real time Image"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).copyWith().size.width *
                                0.1),
                        child: Container(
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.8,
                          child: TextFormField(
                            obscureText: _isobscure1,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
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
                              labelStyle: TextStyle(color: MyColors.brown3),
                              border: UnderlineInputBorder(),
                              labelText: 'Password',
                            ),
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              return value == null || value.isEmpty
                                  ? 'Password Cannot Be Empty'
                                  : null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).copyWith().size.width *
                                0.1),
                        child: Container(
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.8,
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _isobscure,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
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
                              labelStyle: TextStyle(color: MyColors.brown3),
                              border: UnderlineInputBorder(),
                              labelText: 'Confirm Password',
                            ),
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              return value == null || value.isEmpty
                                  ? 'Confirm Password Cannot Be Empty'
                                  : null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).copyWith().size.width *
                              0.25,
                          top: MediaQuery.of(context).copyWith().size.height *
                              0),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      )),
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
                              if (_passwordController.text
                                  .endsWith(_confirmPasswordController.text)) {
                                setState(() {
                                  _errorMessage = "";
                                });
                                var res = await widget.user.updatePassword(
                                    widget.user.id,
                                    _confirmPasswordController.text);
                                if (res.statusCode==200)
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                              } else
                                setState(() {
                                  _errorMessage = "Passwords does not match";
                                });

                              // await widget.user
                              //     .updatePassword(30, "Password@7");
                            }
                          },
                          child: Text(
                            "$_buttonText",
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
