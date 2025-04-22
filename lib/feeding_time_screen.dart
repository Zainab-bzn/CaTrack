import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class FeedingTimeScreen extends StatefulWidget {
  const FeedingTimeScreen({Key? key}) : super(key: key);

  @override
  State<FeedingTimeScreen> createState() => _FeedingTimeScreenState();
}

class _FeedingTimeScreenState extends State<FeedingTimeScreen> {
  TextEditingController _feedingTimeController = TextEditingController();
  List<String> feedingTimes = [];
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _loadFeedingTimes();
    tzData.initializeTimeZones();
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _loadFeedingTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      feedingTimes = prefs.getStringList('feeding_times') ?? [];
    });
  }

  void _saveFeedingTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('feeding_times', feedingTimes);
  }

  void _addFeedingTime(TimeOfDay time) {
    final formattedTime = '${time.hour}:${time.minute}';
    setState(() {
      feedingTimes.add(formattedTime);
      _saveFeedingTimes();
    });

    // Schedule a notification for the selected feeding time
    _scheduleNotification(time);
  }

  void _scheduleNotification(TimeOfDay time) async {
    final now = DateTime.now();
    final scheduledTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    // If the selected time is in the past, schedule it for the next day
    if (scheduledTime.isBefore(now)) {
      scheduledTime.add(Duration(days: 1));
    }

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Feeding Time!',
      'It\'s time to feed your cat!',
      tz.TZDateTime.from(scheduledTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'feeding_channel',
          'Feeding Time Notifications',
          channelDescription: 'Notifications for feeding time',
          importance: Importance.high,
          priority: Priority.high,
          visibility: NotificationVisibility.public,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // Corrected usage
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
    );
  }

  void _resetFeedingTimes() {
    setState(() {
      feedingTimes.clear();
      _saveFeedingTimes();
    });
  }

  // Time Picker to pick feeding time
  Future<void> _selectFeedingTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      _addFeedingTime(selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feeding Time"),
        centerTitle: true,
        backgroundColor: Colors.pink[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Feeding time animation
            SizedBox(
              height: 200,
              child: Lottie.asset(
                'assets/animations/feeding_animation.json',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.white);
                },
              ),
            ),
            const SizedBox(height: 20),

            // Button to pick time
            ElevatedButton(
              onPressed: () => _selectFeedingTime(context),
              child: const Text('Select Feeding Time'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[200],
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // List of added feeding times
            Expanded(
              child: ListView.builder(
                itemCount: feedingTimes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(feedingTimes[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          feedingTimes.removeAt(index);
                          _saveFeedingTimes();
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            // Reset Button
            ElevatedButton(
              onPressed: _resetFeedingTimes,
              child: const Text('Reset Feeding Times'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[200],
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
