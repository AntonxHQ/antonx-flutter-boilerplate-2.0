import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logger/logger.dart';
import 'core/services/localization_service.dart';
import 'locator.dart';

Future<void> main() async {
  final log = Logger();
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await setupLocator();
    runApp(const MyApp());
  } catch (e, s) {
    log.d("$e");
    log.d("$s");
  }
}

// If you're going to use other Firebase services in the background, such as FireStore,
// make sure you call `initializeApp` before using other Firebase services.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final log = Logger();
  await Firebase.initializeApp();
  log.d("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, widget) => GetMaterialApp(
          translations: LocalizationService(),
          locale: const Locale("en"),
          title: "Flutter Demo",
          home: const SplashScreen()),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("HEY ! this is antonx Template used for flutter"),
//       ),
//     );
//   }
// }
