// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class Notification {
//   dynamic initializeLocalNotification() async {
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();

//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/launcher_icon');

//     InitializationSettings initializationSettings =
//         const InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     return flutterLocalNotificationsPlugin;
//     // _showNotification(flutterLocalNotificationsPlugin);
//   }

//   Future<void> showNotification(
//       {required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
//       required String message,
//       required String title}) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       '0',
//       'version_update',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );

//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       message,
//       platformChannelSpecifics,
//       payload: 'item x',
//     );
//   }
// }
