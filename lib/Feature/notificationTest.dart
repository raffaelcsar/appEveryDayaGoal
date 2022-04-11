import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createNotificationMeta() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'Basic',
      title: 'Every Day a Goal',
      body: 'Você atingiu a meta diária, Parabéns!!!',
      bigPicture: 'asset://assets/Rota.jpg',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}
