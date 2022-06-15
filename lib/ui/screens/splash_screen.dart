import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/core/models/other_models/onboarding.dart';
import 'package:flutter_antonx_boilerplate/core/services/auth_service.dart';
import 'package:flutter_antonx_boilerplate/core/services/database_service.dart';
import 'package:flutter_antonx_boilerplate/core/services/local_storage_service.dart';
import 'package:flutter_antonx_boilerplate/core/services/notifications_service.dart';
import 'package:flutter_antonx_boilerplate/ui/custom_widgets/dailogs/network_error_dialog.dart';
import 'package:flutter_antonx_boilerplate/ui/screens/root/root_screen.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../locator.dart';
import 'auth_signup/login/login_screen.dart';
import 'onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authService = locator<AuthService>();
  final _dbService = locator<DatabaseService>();
  final _localStorateService = locator<LocalStorageService>();
  final _notificationService = locator<NotificationsService>();
  List<Onboarding> onboardingList = [];
  final Logger log = Logger();

  @override
  void didChangeDependencies() {
    _initialSetup();
    super.didChangeDependencies();
  }

  _initialSetup() async {
    await _localStorateService.init();

    ///
    /// If not connected to internet, show an alert dialog
    /// to activate the network connection.
    ///
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Get.dialog(NetworkErrorDialog());
      return;
    }

    ////
    ///initializing notification services
    ///
    // await NotificationsService().initConfigure();
    // var fcm = await NotificationsService().getFcmToken();
    // print("FCM TOKEN is =====> $fcm");
    await _notificationService.initConfigure();

    ///getting onboarding data for pre loading purpose
    onboardingList = await _getOnboardingData();
//routing to the last onboarding screen user seen
    if (_localStorateService.onBoardingPageCount + 1 < onboardingList.length) {
      final List<Image> preCachedImages =
          await _preCacheOnboardingImages(onboardingList);
      await Get.to(() => OnboardingScreen(
          currentIndex: _localStorateService.onBoardingPageCount,
          onboardingList: this.onboardingList,
          preCachedImages: preCachedImages));
      return;
    }
    await _authService.doSetup();
    ////
    ///checking if the user is login or not
    ///
    log.d('Login State: ${_authService.isLogin}');
    if (_authService.isLogin) {
      Get.off(() => RootScreen());
    } else {
      Get.off(() => LoginScreen());
    }
  }

  Future<List<Image>> _preCacheOnboardingImages(
      List<Onboarding> onboardingList) async {
    List<Image> preCachedImages =
        onboardingList.map((e) => Image.network(e.imgUrl!)).toList();
    for (Image preCacheImg in preCachedImages) {
      await precacheImage(preCacheImg.image, context);
    }
    return preCachedImages;
  }

  _getOnboardingData() async {
    ///TODO:
    ///uncomment below code

    // final response = await _dbService.getOnboardingData();
    // if (response.success) {
    //   return response.onboardingsList;
    // } else {
    //   return [];
    // }
    List<Onboarding> onboardings = [];
    return onboardings;
  }

  @override
  Widget build(BuildContext context) {
    ///
    /// Splash Screen UI goes here.
    ///
    return Scaffold(
      body: Container(
        child: Center(child: Text('Splash Screen')),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(
        //       "${staticAssetsPath}splash_screen.png",
        //     ),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        // child: Center(
        //   child: Image.asset(
        //     '${staticAssetsPath}mustafed_logo.png',
        //     width: 136.w,
        //     height: 157.h,
        //     fit: BoxFit.contain,
        //   ),
        // ),
      ),
    );
  }
}
