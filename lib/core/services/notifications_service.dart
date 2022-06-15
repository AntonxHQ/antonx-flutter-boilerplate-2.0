import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsService {
  final _fcm = FirebaseMessaging.instance;
  String? fcmToken;

  ///
  ///Initializing Notifiication services that includes FLN, ANDROID NOTIFICATION CHANNEL setting
  ///FCM NOTIFICATION SETTINGS, and also listeners for OnMessage and for onMessageOpenedApp
  ///
  initConfigure() async {
    print("@initFCMConfigure/started");

//now finally get the token from
    await _fcm.getToken().then((token) {
      print("FCM TOKEN IS =======-======>$token");
      this.fcmToken = token;
    });

    fcmToken = await getFcmToken();

    ///
    ///now initialuzing the listenes
    ///
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      // hostUserId = message.data['hostUserId'].toString();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      print('A new onMessageOpenedApp event was published!');
      if (notification != null && android != null) {}
    });

    print("@initConfigure/ENDED");

    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  // print('User granted permission: ${settings.authorizationStatus}');

  onNotificationClick(String payload) {
    print('Payload / notification data message is ====>  $payload');
    // Get.to(() => NotificationScreen2(hostUserId));
  }

  Future<String?> getFcmToken() async {
    return await _fcm.getToken();
  }
}

///
///recived notification model class for ios didNotificationRecieved callback
///
class ReceivedNotification {
  final int? id;
  final String? title;
  final String? body;
  final String? payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}
