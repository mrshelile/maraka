
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:maraka/logic/banner_logic.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/logic/constants.dart';
import 'package:maraka/main.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/screens/home.dart';
import 'package:maraka/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:restart_app/restart_app.dart';
import 'package:swipebuttonflutter/swipebuttonflutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Splashcreen extends StatefulWidget {
  const Splashcreen({Key? key}) : super(key: key);

  @override
  _SplashcreenState createState() => _SplashcreenState();
}

class _SplashcreenState extends State<Splashcreen> {
  User user = User();

  Widget imageCarousel = Carousel(
    boxFit: BoxFit.fill,
    dotBgColor: Colors.transparent,
    dotSize: 0,
    images: [
      SvgPicture.asset("assets/undraw_empty_cart_co35.svg"),
    ],
  );
//  Future sendEmail() async{
//    final username = 'mrdavertzshelile@outlook.com';
// final password = 'S1helile@com';
// final smtpServer = SmtpServer(
//   'smtp-mail.outlook.com',
//   port: 587,
//   username: username,
//   password: password,
// );
// final message = Message()
//   ..from = Address(username, 'Malefetsane Shelile')
//   ..recipients.add('davertzshelile@gmail.com')
//   ..subject = 'New POST message from user'
//   ..text = "this is test email";
//   int statusCode;
// try {
//   final sendReport = await send(message, smtpServer);
//   print(sendReport.toString());
//   statusCode = HttpStatus.ok;
// } on MailerException catch (e) {
//   print('Message not sent: ${e.problems}');
//   statusCode = HttpStatus.internalServerError;
// }
// // request.response
// //   ..statusCode = statusCode
// //   ..close();
//  }
  Future<String> makeBanners() async {
    var logic = BannerLogic();

    await logic.getSplashscreen();

    if (logic.response != null) {
      if (logic.response.statusCode == 200) {
        List imgs = [];
        // List banner = [];
        for (var item in logic.bannersSplashScreen) {
          bool skip = false;
          if (item.display != null) {
            if (item.display['data'] != null) {
              if (item.display['data']['attributes'] != null) {
                if (item.display['data']['attributes']['url'] != null) {
                  // print(item.display['data']['attributes']['url']);
                  imgs.add(server + item.display['data']['attributes']['url']);
                }
              }
            }
          }
        }
        if (imgs.length > 0)
          imageCarousel = Carousel(
            dotBgColor: Colors.transparent,
            dotSize: 0,
            images: logic.bannersSplashScreen
                .map(
                  (i) => GestureDetector(
                    onTap: () async {
                      // print(i);
                      if (!await launch("http://" + i.url)) {
                        print("failed launching");
                      } else {
                        print("should launch");
                      }
                    },
                    child: Image.network(
                      server + i.imgUrl,
                    ),
                  ),
                )
                .toList(),
          );

        return logic.response.toString();
      } else {
        print("first fail");
        return "";
      }
    } else {
      print("second fail");
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    // makeBanners();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomPaint(
            painter: BackgroundDesign(),
            child: Container(),
          ),
          FutureBuilder<String>(
              future: makeBanners(),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).copyWith().size.height *
                            0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width:
                                MediaQuery.of(context).copyWith().size.width *
                                    0.1,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height *
                                  0.2,
                              width:
                                  MediaQuery.of(context).copyWith().size.width *
                                      0.3,
                              child: Image.asset(
                                "assets/maraka.png",
                              )),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).copyWith().size.height *
                            0.07,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).copyWith().size.width *
                                0.14,
                            bottom:
                                MediaQuery.of(context).copyWith().size.height *
                                    0.05),
                        child: const Text(
                          "Shopping made easy, buy and/sell anything, anytime",
                          style:
                              TextStyle(color: MyColors.brown3, fontSize: 20),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          height:
                              MediaQuery.of(context).copyWith().size.height *
                                  0.4,
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.6,
                          child: imageCarousel),
                      SizedBox(
                        height: MediaQuery.of(context).copyWith().size.height *
                            0.05,
                      ),
                      SwipingButton(
                        height:
                            MediaQuery.of(context).copyWith().size.width * 0.1,
                        text: "Swipe To Get Started",
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).copyWith().size.width *
                                0.14,
                            right:
                                MediaQuery.of(context).copyWith().size.width *
                                    0.15),
                        swipeButtonColor: MyColors.blue2,
                        backgroundColor: MyColors.blue3,
                        swipePercentageNeeded: 0.3,
                        onSwipeCallback: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home(
                                        currentIndex: 0,
                                        user: new User(),
                                      )));
                        },
                      ),
                    ],
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(
                        top:
                            MediaQuery.of(context).copyWith().size.height * 0.3,
                        left: MediaQuery.of(context).copyWith().size.width *
                            0.15),
                    child: Column(
                      children: [
                        Container(
                          height:
                              MediaQuery.of(context).copyWith().size.height *
                                  0.3,
                          width: MediaQuery.of(context).copyWith().size.width *
                              0.6,
                          child: SvgPicture.asset("assets/internet.svg",
                              semanticsLabel: "Security Image"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height *
                                  0.01),
                          child: Text("Oops looks like there is no internet"),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .width *
                                    0.1,
                                top: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height *
                                    0.03),
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
                                onPressed: () {
                                  print("object");
                                   Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()));
                                },
                                child: const Text(
                                  "Retry",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            )),
                      ],
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}

// class InitializationApp extends StatelessWidget {
//   final Future _initFuture = Init.initialize();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Initialization',
//       home: FutureBuilder(
//         future: _initFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return HomePage();
//           } else {
//             return SplashScreen();
//           }
//         },
//       ),
//     );
//   }
// }
