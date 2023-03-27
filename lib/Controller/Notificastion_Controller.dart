import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NotificationController extends GetxController{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void initNotification (){
    AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('logo');
    DarwinInitializationSettings darwinInitializationSettings = DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings,iOS: darwinInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showSimpleNotification () async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails("1", "Android",importance: Importance.high,priority: Priority.max);
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(subtitle: 'ios');
    NotificationDetails notificationDetails = NotificationDetails(iOS: darwinNotificationDetails,android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(1, "MY SHOP", "Product Successfully Add Cart ", notificationDetails);
  }
}
