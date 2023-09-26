// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:web_socket_channel/io.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: WebSocketNotifications(),
//     );
//   }
// }

// class WebSocketNotifications extends StatefulWidget {
//   @override
//   _WebSocketNotificationsState createState() => _WebSocketNotificationsState();
// }

// class _WebSocketNotificationsState extends State<WebSocketNotifications> {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   late IOWebSocketChannel channel;

//   @override
//   void initState() {
//     super.initState();
//     _initializeLocalNotifications();
//     _initializeWebSocket();
//   }

//   void _initializeLocalNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.initialize(initializationSettingsAndroid);
//   }

//   void _initializeWebSocket() {
//     channel = IOWebSocketChannel.connect('wss://your_websocket_server_url');

//     channel.stream.listen((message) {
//       _showNotification(message);
//     });
//   }

//   Future<void> _showNotification(String message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       'your_channel_description',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       'WebSocket Message',
//       message,
//       platformChannelSpecifics,
//       payload: 'payload',
//     );
//   }

//   @override
//   void dispose() {
//     channel.sink.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('WebSocket Notifications'),
//       ),
//       body: Center(
//         child: Text('WebSocket notifications will be displayed here.'),
//       ),
//     );
//   }
// }
