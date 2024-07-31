import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/screens/splash_screen.dart';

// void main() {
//   runApp(MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // BackgroundService.start();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(StoreController());
    Get.put(User());

    return GetMaterialApp(
      title: 'Maraka',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: const SplashScreen(),
      ),
    );
  }
}
