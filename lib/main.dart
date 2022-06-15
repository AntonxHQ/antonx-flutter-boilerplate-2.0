import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/services/localization_service.dart';
import 'locator.dart';

Future<void> main() async {
  // final Logger log = Logger();
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
//for notifiications
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await setupLocator();
    runApp(MyApp());
  } catch (e, s) {
    print("$e");
    print("$s");
  }
}

// If you're going to use other Firebase services in the background, such as Firestore,
// make sure you call `initializeApp` before using other Firebase services.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //TODO: Screen sizes to be changed according to the design provided
      designSize: Size(375, 812),
      builder: (context, widget) => GetMaterialApp(
          translations: LocalizationService(),
          locale: Locale("en"),
          title: "Flutter Demo",
          home: SplashScreen()),
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
