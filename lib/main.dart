import 'package:everydayagoal/Feature/notification.dart';
import 'package:everydayagoal/screens/historic.dart';
import 'package:flutter/material.dart';
import 'Screens/home.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
  AwesomeNotifications().initialize('resource://drawable/ic_run', [
    NotificationChannel(
        channelKey: 'Basic',
        channelName: 'Meta',
        channelDescription: 'Meta diária alcançada',
        defaultColor: Colors.deepPurple,
        importance: NotificationImportance.High,
        channelShowBadge: true)
  ]);

  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HistoricPage(),
      routes: {
        '/Home': (context) => HomePage(),
      },
    );
  }
}
