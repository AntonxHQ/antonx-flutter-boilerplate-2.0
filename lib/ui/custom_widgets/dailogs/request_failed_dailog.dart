import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestFailedDialog extends StatelessWidget {
  final errorMessage;

  RequestFailedDialog({@required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('requestFailedTitle'.tr),
      content: Text("$errorMessage"),
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
