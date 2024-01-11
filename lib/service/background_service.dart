// import 'dart:async';
// import 'package:maraka/logic/constants.dart';
// import 'package:maraka/service/notification_service.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class BackgroundService {
//   static IO.Socket? _socket;
//   static final FlutterLocalNotificationsPlugin _localNotifications =
//       FlutterLocalNotificationsPlugin();

//   static void start() async {
//     FlutterBackgroundService().startService();
//     var noti = Notification();
//     var iniNoti = await noti.initializeLocalNotification();
//     // Initialize WebSocket
//     _socket = IO.io(ws_server, <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//     });
//     // print("object");
//     _socket!.on('connect', (_) {
//       print('Connected to WebSocket server');
//     });
//     _socket!.on(
//         "flutter_client_notification",
//         (data) => {
//               noti.showNotification(
//                   flutterLocalNotificationsPlugin: iniNoti,
//                   message: data['message'],
//                   title: data['title'])
//             });
//     _socket!.on('disconnect', (_) {
//       print('Disconnected from WebSocket server');
//     });

//     // _socket!.on('message', (data) {
//     //   final message = data['message'];

//     // });
//   }

//   // static Future<void> _showNotification(String message) async {
//   //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//   //       AndroidNotificationDetails(
//   //     'your_channel_id',
//   //     'your_channel_name',
//   //     importance: Importance.max,
//   //     priority: Priority.high,
//   //   );
//   //   const NotificationDetails platformChannelSpecifics =
//   //       NotificationDetails(android: androidPlatformChannelSpecifics);

//   //   await _localNotifications.show(
//   //     0, // Notification ID
//   //     'WebSocket Message',
//   //     message,
//   //     platformChannelSpecifics,
//   //     payload: 'payload',
//   //   );
//   // }
// }
