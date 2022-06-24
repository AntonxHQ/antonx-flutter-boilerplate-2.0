import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_antonx_boilerplate/core/models/body/login_body.dart';
import 'package:flutter_antonx_boilerplate/core/models/body/reset_password_body.dart';
import 'package:flutter_antonx_boilerplate/core/models/body/signup_body.dart';
import 'package:flutter_antonx_boilerplate/core/models/other_models/apple_auth_object.dart';
import 'package:flutter_antonx_boilerplate/core/models/other_models/user_profile.dart';
import 'package:flutter_antonx_boilerplate/core/models/responses/auth_response.dart';
import 'package:flutter_antonx_boilerplate/core/models/responses/user_profile_response.dart';
import 'package:flutter_antonx_boilerplate/core/others/logger_customizations/custom_logger.dart';
import 'package:flutter_antonx_boilerplate/core/services/database_service.dart';
import 'package:flutter_antonx_boilerplate/core/services/device_info_service.dart';
import 'package:flutter_antonx_boilerplate/core/services/local_storage_service.dart';
import 'package:flutter_antonx_boilerplate/core/services/notifications_service.dart';
import 'package:flutter_antonx_boilerplate/locator.dart';
import 'package:flutter_antonx_boilerplate/ui/custom_widgets/dialogs/auth_dialog.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

///
/// [AuthService] class contains all authentication related logic with following
/// methods:
///
/// [doSetup]: This method contains all the initial authentication like checking
/// login status, onboarding status and other related initial app flow setup.
///
/// [signupWithEmailAndPassword]: This method is used for signup with email and password.
///
/// [signupWithApple]:
///
/// [signupWithGmail]:
///
/// [signupWithFacebook]:
///
/// [logout]:
///

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _facebookLogin = FacebookAuth.instance;
  late bool isLogin;
  final _localStorageService = locator<LocalStorageService>();
  final _dbService = locator<DatabaseService>();
  UserProfile? userProfile;
  String? fcmToken;
  static final Logger log = CustomLogger(className: 'AuthService');

  ///
  /// [doSetup] Function does the following things:
  ///   1) Checks if the user is logged then:
  ///       a) Get the user profile data
  ///       b) Updates the user FCM Token
  ///
  doSetup() async {
    isLogin = _localStorageService.accessToken != null;
    if (isLogin) {
      log.d('User is already logged-in');
      await _getUserProfile();
      await _updateFcmToken();
    } else {
      log.d('@doSetup: User is not logged-in');
    }
  }

  _getUserProfile() async {
    UserProfileResponse response = await _dbService.getUserProfile();
    if (response.success) {
      userProfile = response.profile;
      log.d('Got User Data: ${userProfile?.toJson()}');
    } else {
      Get.dialog(AuthDialog(title: 'Title', message: response.error!));
    }
  }

  ///
  /// Updating FCM Token here...
  ///
  _updateFcmToken() async {
    final fcmToken = await locator<NotificationsService>().getFcmToken();
    final deviceId = await DeviceInfoService().getDeviceId();
    final response = await _dbService.updateFcmToken(deviceId, fcmToken!);
    if (response.success) {
      userProfile!.fcmToken = fcmToken;
    }
  }

  signupWithEmailAndPassword(SignUpBody body) async {
    late AuthResponse response;
    response = await _dbService.createAccount(body);
    if (response.success) {
      userProfile = UserProfile.fromJson(body.toJson());
      _localStorageService.accessToken = response.accessToken;
      await _updateFcmToken();
    }
    return response;
  }

  loginWithEmailAndPassword(LoginBody body) async {
    late AuthResponse response;
    response = await _dbService.loginWithEmailAndPassword(body);
    if (response.success) {
      _localStorageService.accessToken = response.accessToken;
      await _getUserProfile();
      _updateFcmToken();
    }
    return response;
  }

  resetPassword(ResetPasswordBody body) async {
    final AuthResponse response = await _dbService.resetPassword(body);
    if (response.success) {
      _localStorageService.accessToken = response.accessToken;
    }
    return response;
  }

  ///
  /// Google SignIn
  ///
  Future<AuthResponse> loginWithGoogle() async {
    late AuthResponse response;
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      log.d('accessToken => ' + googleAuth.accessToken!);
      log.d('idToken => ' + googleAuth.idToken!);
      response = await _dbService.loginWithGoogle(googleAuth.accessToken!);
      if (response.success) {
        if (response.success) {
          _localStorageService.accessToken = response.accessToken;
          // isNotificationTurnOn = _localStorageService.notificationFlag != null;
          await _getUserProfile();
          // if (isNotificationTurnOn) await _updateFcmToken();
        }
      }
      return response;
    } catch (e) {
      log.e('Exception @signUpWithGoogle: $e');
    }
    return response;
  }

  loginWithFacebook() async {
    late AuthResponse response;
    try {
      final LoginResult result = await _facebookLogin.login();
      final AccessToken accessToken = result.accessToken!;
      response = await _dbService.loginWithFacebook(accessToken.token);
      if (response.success) {
        _localStorageService.accessToken = response.accessToken;
        // isNotificationTurnOn = _localStorageService.notificationFlag != null;
        await _getUserProfile();
        // if (isNotificationTurnOn) await _updateFcmToken();
      }
      return response;
    } catch (e) {
      log.i('Exception @loginWithFacebook: $e');
    }
    return response;
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  loginWithApple() async {
    late AuthResponse response;
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    AppleAuthObject appleAuthObject = AppleAuthObject();
    appleAuthObject.accessKey =
        r'$2y$10$SkFPPJPfL.8x9jwhibLE.5JPcdFk9Iloaudxf8VkvYAO4jUbEp1K';
    try {
      final appleCredentials = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      appleAuthObject.email = appleCredentials.email;
      appleAuthObject.username =
          '${appleCredentials.givenName} ${appleCredentials.familyName}';
      appleAuthObject.identityToken = appleCredentials.identityToken;
      appleAuthObject.authorizationCode = appleCredentials.authorizationCode;
      appleAuthObject.appleUserId = appleCredentials.userIdentifier;
      log.i(
          "AccessCode => ${appleCredentials.authorizationCode} \n Email => ${appleCredentials.email} \n UserName => ${appleCredentials.givenName} ${appleCredentials.familyName}\n UserId => ${appleCredentials.userIdentifier} \n");
      response = await _dbService.loginWithApple(appleAuthObject);
      if (response.success) {
        _localStorageService.accessToken = response.accessToken;
        // isNotificationTurnOn = _localStorageService.notificationFlag != null;
        await _getUserProfile();
        // if (isNotificationTurnOn) await _updateFcmToken();
      }
      return response;
    } catch (e) {
      log.i('Exception @loginWithApple: $e');
    }
    return response;
  }

  logout() async {
    isLogin = false;
    userProfile = null;
    await _dbService.clearFcmToken(await DeviceInfoService().getDeviceId());
    _localStorageService.accessToken = null;
  }
}
