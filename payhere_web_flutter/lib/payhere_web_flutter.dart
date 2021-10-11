@JS()
library payhere_web_flutter;

import 'dart:convert';
import 'dart:developer';
import 'package:js/js.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:payhere_platform_interface/payhere_platform_interface.dart';

class PayHerePlugin extends PayHerePlatform {
  /// Registers this class as the default instance of [UrlLauncherPlatform].
  static void registerWith(Registrar registrar) {
    PayHerePlatform.instance = PayHerePlugin();
  }

  //overrides default method
  @override
  Future<void> startPayment(
      Map paymentObject,
      PayHereOnCompletedHandler onCompleted,
      PayHereOnErrorHandler onError,
      PayHereOnDismissedHandler onDismissed) async {
    PayHereJS.onCompleted = allowInterop(onCompleted);
    PayHereJS.onError = allowInterop(onError);
    PayHereJS.onDismissed = allowInterop(onDismissed);
    print(json.encode(paymentObject));
    await PayHereJS.startPaymentJS(json.encode(paymentObject));
  }
}

@JS('payhere')
class PayHereJS {
  @JS('onCompleted')
  external static PayHereOnCompletedHandler onCompleted;
  @JS('onError')
  external static PayHereOnErrorHandler onError;
  @JS('onDismissed')
  external static PayHereOnDismissedHandler onDismissed;
  @JS('startPayment')
  external static Future<void> startPaymentJS(String paymentObject);
}
