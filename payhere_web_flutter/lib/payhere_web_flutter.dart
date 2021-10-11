@JS()
library payhere_web_flutter;

import 'dart:convert';
import 'dart:developer';
import 'package:js/js.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:payhere_platform_interface/payhere_platform_interface.dart';

/// On the payhere.js web implementation, you do not get the payment Id. You only get the Order ID!
typedef PayHereWebOnCompletedHandler = void Function(String orderId);

class PayHerePlugin extends PayHerePlatform {
  /// Registers this class as the default instance of [UrlLauncherPlatform].
  static void registerWith(Registrar registrar) {
    PayHerePlatform.instance = PayHerePlugin();
  }

  //overrides default method
  @override
  Future<void> startPayment(
      Map paymentObject,
      PayHereWebOnCompletedHandler onCompleted,
      PayHereOnErrorHandler onError,
      PayHereOnDismissedHandler onDismissed) async {
    PayHereJS.setOnCompleted(allowInterop(onCompleted));
    PayHereJS.setOnError(allowInterop(onError));
    PayHereJS.setOnDismissed(allowInterop(onDismissed));
    print(json.encode(paymentObject));
    await PayHereJS.startPaymentJS(json.encode(paymentObject));
  }
}

@JS('payhere_flutter_web')
class PayHereJS {
  @JS('setOnCompleted')
  external static setOnCompleted(PayHereWebOnCompletedHandler handler);
  @JS('setOnError')
  external static setOnError(PayHereOnErrorHandler handler);
  @JS('setOnDismissed')
  external static setOnDismissed(PayHereOnDismissedHandler handler);
  @JS('startPayment')
  external static Future<void> startPaymentJS(String paymentObject);
}
