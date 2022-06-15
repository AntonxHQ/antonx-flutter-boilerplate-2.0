import 'dart:io';
import 'package:dio/dio.dart' as dio;

class SignUpBody {
  String? email;
  String? password;
  String? name;
  String? location;
  String? gender;
  String? phone;
  File? image;
  // String? fcmToken;

  /// Other fields to be added as well.

  SignUpBody({
    this.email,
    this.password,
    this.gender,
    this.location,
    this.name,
    this.phone,
    this.image,
    // this.fcmToken,
  });

  toJson() async {
    return {
      'email': this.email,
      'password': this.password,
      'name': this.name,
      'location': this.location,
      'gender': this.gender,
      'phone': this.phone,
      'image':
          image != null ? await dio.MultipartFile.fromFile(image!.path) : null,
      // 'fcm_token': this.fcmToken,
    };
  }
}
