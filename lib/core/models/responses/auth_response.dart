import 'package:flutter_antonx_boilerplate/core/models/responses/base_responses/base_response.dart';

class AuthResponse extends BaseResponse {
  String? accessToken;

  /// Default constructor
  AuthResponse(success, {error, this.accessToken})
      : super(success, error: error);

  /// Named Constructor
  AuthResponse.fromJson(json) : super.fromJson(json) {
    if (json['body'] != null) this.accessToken = json['body']['token'];
  }
}
