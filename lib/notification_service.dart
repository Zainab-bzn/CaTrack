import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Initialize the notification plugin and timezone
  static Future<void> init() async {
    // Initialize timezone
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Call this to schedule a notification
  static Future<void> scheduleFeedingReminder() async {
    final tz.TZDateTime scheduledTime = tz.TZDateTime.from(
      DateTime.now().add(Duration(seconds: 10)), // You can change the delay
      tz.local,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Feeding Time Reminder',
      'It\'s time to feed your cat!',
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'feeding_channel_id', // Must match the channelId used in Android
          'Feeding Notifications',
          channelDescription: 'Reminds you to feed your cat',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
