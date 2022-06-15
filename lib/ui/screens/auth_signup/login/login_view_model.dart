import 'package:flutter/widgets.dart';
import 'package:flutter_antonx_boilerplate/core/enums/view_state.dart';
import 'package:flutter_antonx_boilerplate/core/models/body/login_body.dart';
import 'package:flutter_antonx_boilerplate/core/models/responses/auth_response.dart';
import 'package:flutter_antonx_boilerplate/core/others/base_view_model.dart';
import 'package:flutter_antonx_boilerplate/core/services/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  bool isRemeberMe = false;
  AuthService authService = AuthService();
  LoginBody loginBody = LoginBody();
  late AuthResponse response;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisibility = true;

  togglePasswordVisibility() {
    setState(ViewState.busy);
    passwordVisibility = !passwordVisibility;
    setState(ViewState.idle);
  }

  requestLogin() async {
    setState(ViewState.busy);
    try {
      response = await authService.loginWithEmailAndPassword(loginBody);
    } catch (e, s) {
      print("@LoginViewModel requestLogin Exceptions : $e");
      print(s);
    }
    setState(ViewState.idle);
  }

  toggleIsRememberMe() {
    debugPrint('@toggleIsRememberMe: isRemeberMe: $isRemeberMe');
    isRemeberMe = !isRemeberMe;
    notifyListeners();
  }
}
