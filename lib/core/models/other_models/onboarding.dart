import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/core/services/localization_service.dart';

class Onboarding {
  late String? imgUrl;
  late String? title;

  Onboarding(this.imgUrl, this.title);

  Onboarding.fromJson(json) {
    debugPrint('$json');
    this.title = json[LocalizationService.getLocalizedKey('title')];
    this.imgUrl = json['image_url'];
  }
}
