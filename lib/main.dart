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

  final user = User();
  await user.restoreSession();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  final User user;

  const MyApp({super.key, required this.user});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(StoreController());
    Get.put(user, permanent: true);

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
