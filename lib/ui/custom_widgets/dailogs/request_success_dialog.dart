import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestSuccessDialog extends StatelessWidget {
  final successMsg;

  RequestSuccessDialog({@required this.successMsg});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('requestSuccessTitle'.tr),
      content: Text("$successMsg"),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('ok'.tr),
        ),
      ],
    );
  }
}
