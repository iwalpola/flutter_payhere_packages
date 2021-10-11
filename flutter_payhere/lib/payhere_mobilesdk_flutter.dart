import 'dart:async';

import 'package:payhere_platform_interface/payhere_platform_interface.dart';

typedef PayHereOnCompletedHandler = void Function(String paymentId);
typedef PayHereOnErrorHandler = void Function(String error);
typedef PayHereOnDismissedHandler = void Function();

class PayHere {
  static Future<void> startPayment(
      Map paymentObject,
      PayHereOnCompletedHandler onCompleted,
      PayHereOnErrorHandler onError,
      PayHereOnDismissedHandler onDismissed) async {
    await PayHerePlatform.instance
        .startPayment(paymentObject, onCompleted, onError, onDismissed);
  }
}