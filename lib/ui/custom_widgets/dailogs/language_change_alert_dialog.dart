import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageChangeAlertDialog extends StatelessWidget {
  final message;

  LanguageChangeAlertDialog({@required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('chage_lang'.tr),
      content: Text("$message"),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: Text('yes'.tr),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: Text('no'.tr),
        ),
      ],
    );
  }
}
