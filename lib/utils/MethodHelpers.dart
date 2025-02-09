import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class MethodHelpers {
  static showFlushBar({
    String tittle = "",
    String subTitle = "",
    Color color = Colors.white,
  }) {
    if (StackedService.navigatorKey != null &&
        StackedService.navigatorKey!.currentContext != null) {
      return Flushbar(
        title: tittle,
        titleColor: Colors.white,
        message: subTitle,
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.decelerate,
        forwardAnimationCurve: Curves.elasticOut,
        backgroundColor: color,
        isDismissible: false,
        duration: const Duration(seconds: 4),
      ).show(StackedService.navigatorKey!.currentContext!);
    }
  }
}
