import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class Notification {

  FlutterLocalNotificationsPlugin localNotification = FlutterLocalNotificationsPlugin();


  @override
  void initState() {
    super.initState();
    var settingsAndroid = const AndroidInitializationSettings('Flutter_devs');
    var settings = 
      InitializationSettings(android: settingsAndroid);
      localNotification.initialize(settings);
}


  @override 
  Future <dynamic> notification() async {
    var android = const AndroidNotificationDetails('id', 'Meta', 'Notificação de meta alcançada',
    playSound: true);
    var platform = NotificationDetails(android: android);
    await localNotification.show(
      0, 'Flutter devs', 'Flutter local notification', platform,
      payload: 'Você bateu sua meta!');
  }
}


  

  //   Future<void> _proximitySensor() async{
  //   _streamSubscription = ProximitySensor.events.listen((event){
  //     setState((){
  //       isNear = true;
  //       if (isNear){
  //         // Vibration.vibrate(duration: 1000, amplitude:128, repeat: 1);
  //       } else {
  //         isNear = false;
  //       }
  //      });
  //   });
  // }