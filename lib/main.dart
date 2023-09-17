import 'package:get/get.dart';
import 'package:maraka/logic/store.dart';
import 'package:maraka/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
// void main() {
//   runApp(MyApp());
// }
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().initialize(
  // set the icon to null if you want to use the default app icon
  '',
  [
    NotificationChannel(
        channelGroupKey: 'version_update',
        channelKey: 'basic_channel',
        channelName: 'VersionUpdate',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white)
  ],
  // Channel groups are only visual and are not required
  channelGroups: [
    NotificationChannelGroup(
        channelGroupName: 'VersionUpdate', channelGroupkey: 'version_update')
  ],
  debug: true
);
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
    final store = Get.put(StoreController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
        title: 'Maraka',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blueGrey,
        ),
        home: const Splashcreen(),

        // home: CarouselSelectWidgetSample(),
      ),
    );
  }
}
