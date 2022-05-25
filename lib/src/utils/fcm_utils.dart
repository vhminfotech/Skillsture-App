// import 'dart:io';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:provider/provider.dart';
//
// import '../apis/dic_params.dart';
// import '../ui/chat/provider/chat_provider.dart';
// import '../ui/profile/supportTickets/provider/support_chat_provider.dart';
// import 'constants.dart';
// import 'dialog_utils.dart';
// import 'image_constants.dart';
// import 'navigation.dart';
// import 'navigation_params.dart';
// import 'notification_constants.dart';
// import 'preference_key.dart';
// import 'preference_utils.dart';
//
// const channel = AndroidNotificationChannel(
//   DicParams.paramChannelId,
//   DicParams.paramChannelName,
//   DicParams.paramChannelDescription,
//   importance: Importance.high,
// );
// final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// Future<void> firebaseMessagingConfig(BuildContext buildContext) async {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//   await _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true);
//
//   await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//
//   await _flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   FirebaseMessaging.onMessage.listen((message) {
//     FlutterAppBadger.updateBadgeCount(1);
//     showNotification(message);
//   });
//
//   FirebaseMessaging.onMessageOpenedApp.listen((message) {
//     navigateToScreen(
//         context: buildContext, message: message.data, fromNotification: true);
//   });
//
//   Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     navigateToScreen(
//         context: buildContext, message: message.data, fromNotification: true);
//   }
//
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// }
//
// void showNotification(RemoteMessage message) {
//   var notification = message.notification;
//   var android = message.notification?.android;
//   if (notification != null && android != null) {
//     _flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channel.description,
//           icon: DicParams.paramICLauncher,
//           priority: Priority.max,
//           enableLights: true,
//         ),
//       ),
//     );
//   }
// }
//
// void navigateToScreen(
//     {BuildContext context,
//     Map<String, dynamic> message,
//     bool fromNotification}) {
//   print("$message");
//   switch (Platform.isAndroid
//       ? message[DicParams.data][DicParams.actionType]
//       : message[DicParams.actionType]) {
//     case NotificationConstants.requested:
//       // openChatScreen(context, message);
//       DialogUtils.showStatementDialog(
//           image: ImageConstants.icSuccess,
//           headerText: """${message[DicParams.notification][DicParams.title]}""",
//           onOkClick: () {},
//           context: context);
//       break;
//     case NotificationConstants.userChat:
//       openChatScreen(context, message);
//       break;
//     case NotificationConstants.approved:
//       // openChatScreen(context, message);
//       DialogUtils.showStatementDialog(
//           image: ImageConstants.icSuccess,
//           headerText: """${message[DicParams.notification][DicParams.title]}""",
//           onOkClick: () {},
//           context: context);
//       break;
//     case NotificationConstants.support:
//       getString(PreferenceKey.routeName) == routeSupportTickets
//           ? NavigationUtils.pushReplacement(context, routeSupportTickets,
//               arguments: {NavigationParams.showBackButton: true})
//           : NavigationUtils.push(context, routeSupportTickets,
//               arguments: {NavigationParams.showBackButton: true});
//       break;
//     case NotificationConstants.chat:
//       openChatScreen(context, message);
//       break;
//     case NotificationConstants.supportChat:
//       openSupportChatScreen(context, message);
//       break;
//     case NotificationConstants.newMessage:
//       openSupportChatScreen(context, message);
//       break;
//     case NotificationConstants.ticketClosed:
//       // openSupportChatScreen(context, message);
//       DialogUtils.showStatementDialog(
//           image: ImageConstants.icSuccess,
//           headerText: """${message[DicParams.notification][DicParams.title]}""",
//           onOkClick: () {},
//           context: context);
//       break;
//     case NotificationConstants.utilityBillPayment:
//       DialogUtils.showStatementDialog(
//           image: ImageConstants.icSuccess,
//           headerText: """${message[DicParams.notification][DicParams.body]}""",
//           onOkClick: () {},
//           context: context);
//       break;
//     default:
//       break;
//   }
// }
//
// void openSupportChatScreen(BuildContext context, Map<String, dynamic> message) {
//   final ticketId = int.parse(Platform.isAndroid
//       ? message[DicParams.data][DicParams.ticketId]
//       : message[DicParams.ticketId]);
//   if (Provider.of<SupportChatProvider>(context, listen: false).ticketId !=
//       ticketId) {
//     if (Provider.of<SupportChatProvider>(context, listen: false).isScreenOpen) {
//       NavigationUtils.pushReplacement(context, routeSupportTicketsChat,
//           arguments: {NavigationParams.senderUserId: ticketId});
//     } else {
//       NavigationUtils.push(context, routeSupportTicketsChat,
//           arguments: {NavigationParams.senderUserId: ticketId});
//     }
//   }
// }
//
// void openChatScreen(BuildContext context, Map<String, dynamic> message) {
//   final userId = int.parse(Platform.isAndroid
//       ? message[DicParams.data][DicParams.userId]
//       : message[DicParams.userId]);
//   if (Provider.of<ChatProvider>(context, listen: false).userId != userId) {
//     if (Provider.of<ChatProvider>(context, listen: false).isScreenOpen) {
//       NavigationUtils.pushReplacement(context, routeChatScreen,
//           arguments: {NavigationParams.senderUserId: userId});
//     } else {
//       NavigationUtils.push(context, routeChatScreen,
//           arguments: {NavigationParams.senderUserId: userId});
//     }
//   }
// }
