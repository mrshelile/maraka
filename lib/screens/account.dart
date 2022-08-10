import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/screens/home.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class Account extends StatefulWidget {
  int currentIndex;
  User user;
  Account({Key? key, required this.currentIndex, required this.user})
      : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  // static var _name = "";
  // static var _phone1;
  // static var _phone2;
  static bool isSecondNumber = false;
  static final _profileformKey = GlobalKey<FormState>();
  static final _phone1Controller = TextEditingController();
  static final _phone2Controller = TextEditingController();
  static final _fullNameController = TextEditingController();
  static final _emailController = TextEditingController();
  // static var _email = "";
  static bool _isenabled = false;
  // static var _months = 0;
  bool _isProfileBtnSave = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).copyWith().size.height;
    var width = MediaQuery.of(context).copyWith().size.width;
    double subscriptionProgressBar() {
      var ratio = 0.0;
      if (widget.user.subscription != null) {
        if (widget.user.subscription!.isBefore(DateTime.now())) {
          var subcrip = widget.user.subscription!.millisecondsSinceEpoch /
              (1000).floorToDouble();
          var now =
              (DateTime.now().millisecondsSinceEpoch / 1000).floorToDouble();
          var difference = subcrip - now;
          ratio = difference / subcrip;
        } else {
          ratio = 0.0;
        }
      }
      // ignore: avoid_print

      return ratio;
    }

    ;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomPaint(
            painter: BackgroundDesign(),
            child: Container(),
          ),
          SingleChildScrollView(
            child: Form(
                key: _profileformKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(top: height * 0.1, left: width * 0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * 0,
                              ),
                              child: SvgPicture.asset(
                                "assets/profile.svg",
                                semanticsLabel: "Profile Image",
                                fit: BoxFit.scaleDown,
                                width: width * 0.35,
                                height: height * 0.25,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.1),
                              child: Container(
                                width: width * 0.45,
                                child: TextFormField(
                                  controller: _fullNameController,
                                  decoration: InputDecoration(
                                    labelStyle:
                                        TextStyle(color: MyColors.blue3),
                                    hintText: "full Names",
                                    labelText: widget.user.name,
                                    enabled: false,
                                    border: InputBorder.none,
                                  ),
                                  validator: (String? value) {
                                    return value == null || value.isEmpty
                                        ? 'Enter Your Full Names'
                                        : null;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.05,
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // border: Border(top: BorderSide(color: MyColors.blue2)),
                            color: Colors.white,
                          ),
                          width: width,
                          height: height * 0.45,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: width * 0.3),
                                      child: const Text(
                                        "Personal Information",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    TextButton(
                                      child: const Text(
                                        "Sign Out",
                                        style:
                                            TextStyle(color: MyColors.blue3),
                                      ),
                                      onPressed: () {
                                        widget.user.removeAll();
                                        print(widget.user.jwt);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home(
                                                      currentIndex: 0,
                                                      user: widget.user,
                                                    )));
                                      },
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.1),
                                  child: SizedBox(
                                    width: width,
                                    height: height * 0.08,
                                    child: TextFormField(
                                      controller: _phone1Controller,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.phone_rounded,
                                          color: MyColors.brown3,
                                        ),
                                        // suffixIcon: IconButton(
                                        //   onPressed: () {
                                        //     Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //             builder: (context) => Home()));
                                        //   },
                                        //   icon: Icon(
                                        //     Icons.add,
                                        //     color: MyColors.blue3,
                                        //   ),
                                        // ),
                                        labelStyle:
                                            const TextStyle(color: MyColors.blue3),
                                        hintText: "Phone Numbers",
                                        labelText:
                                            widget.user.phone1.toString(),
                                        enabled: _isenabled,
                                        border: InputBorder.none,
                                      ),
                                      validator: (String? value) {
                                        return value == null || value.isEmpty
                                            ? 'Phone Number'
                                            : null;
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.1),
                                  child: SizedBox(
                                    width: width,
                                    height: height * 0.08,
                                    child: TextFormField(
                                      controller: _phone2Controller,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.phone_rounded,
                                          color: MyColors.brown3,
                                        ),
                                        labelStyle: isSecondNumber
                                            ? const TextStyle(color: MyColors.blue3)
                                            : const TextStyle(color: Colors.brown),
                                        hintText: "Phone Numbers",
                                        labelText: widget.user.phone2
                                                    .toString()
                                                    .isEmpty ||
                                                widget.user.phone2 == null
                                            ? "Phone Numbers"
                                            : widget.user.phone2.toString(),
                                        enabled: _isenabled,
                                        border: InputBorder.none,
                                      ),
                                      // validator: (String? value) {
                                      //   return value == null || value.isEmpty
                                      //       ? 'Phone Number'
                                      //       : null;
                                      // },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.1),
                                  child: SizedBox(
                                    width: width,
                                    height: height * 0.08,
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.email,
                                          color: MyColors.brown3,
                                        ),
                                        labelStyle:
                                            const TextStyle(color: MyColors.blue3),
                                        hintText: "Email Address",
                                        labelText: widget.user.email,
                                        enabled: false,
                                        border: InputBorder.none,
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (String? value) {
                                        return value == null || value.isEmpty
                                            ? 'Email Address Cannot be empty'
                                            : null;
                                      },
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: MyColors.brown2,
                                ),
                                
                                // Rowrrrr
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // Navigator.push(
      //     //     context, MaterialPageRoute(builder: (context) => CreateAds()));

      //     setState(() {
      //       _isProfileBtnSave = !_isProfileBtnSave;
      //       _isenabled = !_isenabled;
      //       if (_phone1Controller.text.isNotEmpty)
      //         widget.user.phone1 = int.parse(_phone1Controller.text);
      //       if (_phone2Controller.text.isNotEmpty)
      //         widget.user.phone2 = int.parse(_phone2Controller.text);
      //       if (!_isProfileBtnSave) {
      //         _phone2Controller.clear();
      //         _phone1Controller.clear();
      //       }
      //     });
      //     var res = await widget.user.updateDetails();
      //   },
      //   tooltip: 'edit Profile',
      //   backgroundColor: MyColors.blue3,
      //   foregroundColor: MyColors.brown3,
      //   child: _isProfileBtnSave
      //       ? Icon(Icons.done_rounded)
      //       : Icon(Icons.create_outlined),
      // ),
    );
  }
}
