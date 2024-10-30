import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String message;

  ErrorMessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) {
      return Container();
    }
    Future.delayed(Duration(milliseconds: 0), () {
      FlushbarHelper.createError(
        message: message,
        title: 'Error',
        duration: Duration(seconds: 3),
      ).show(context);
    });
    return Container();
  }
}
