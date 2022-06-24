///
/// [accessKey] is actually a token which we are verify in
/// the app laravel server to ensure this apis is spammed
/// and misused.
///

class AppleAuthObject {
  String? email;
  String? username;
  String? authorizationCode;
  String? identityToken;
  String? appleUserId;
  String? accessKey;
  String? accessToken;

  AppleAuthObject(
      {this.email,
      this.username,
      this.authorizationCode,
      this.identityToken,
      this.appleUserId,
      this.accessKey,
      this.accessToken});

  AppleAuthObject.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    authorizationCode = json['authorization_code'];
    identityToken = json['identity_token'];
    appleUserId = json['apple_user_id'];
    accessKey = json['access_key'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['username'] = username;
    data['authorization_code'] = authorizationCode;
    data['identity_token'] = identityToken;
    data['apple_user_id'] = appleUserId;
    data['access_key'] = accessKey;
    data['accessToken'] = accessToken;
    return data;
  }
}
