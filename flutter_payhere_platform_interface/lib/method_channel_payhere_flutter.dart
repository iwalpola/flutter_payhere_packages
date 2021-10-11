import 'dart:async';

import 'package:flutter/services.dart';

import 'payhere_platform_interface.dart';

//TODO: consider moving this into the class
const MethodChannel _channel = MethodChannel('payhere_mobilesdk_flutter');

/// An implementation of [PayHerePlatform] that uses method channels.
class MethodChannelPayHere extends PayHerePlatform {
  @override
  Future<void> startPayment(
      Map paymentObject,
      PayHereOnCompletedHandler onCompleted,
      PayHereOnErrorHandler onError,
      PayHereOnDismissedHandler onDismissed) async {
    const _resultKeySuccess = 'success';
    const _resultKeyData = 'fldata';
    const _resultKeyCallback = 'flcallback';

    const _resultCallbackTypeError = 'error';
    const _resultCallbackTypeDismiss = 'dismiss';

    // On return, value is a List<dynamic>
    List<dynamic>? value = await _channel.invokeMethod<List<dynamic>>(
        "startPayment", paymentObject);

    if (value != null) {
      dynamic resultDictionary = value[0];
      Map<dynamic, dynamic> result = resultDictionary as Map<dynamic, dynamic>;
      bool resultSuccess = result[_resultKeySuccess] as bool;

      if (resultSuccess) {
        String resultPaymentId = result[_resultKeyData] as String;
        onCompleted(resultPaymentId);
      } else {
        String resultCallbackType = result[_resultKeyCallback] as String;
        if (resultCallbackType == _resultCallbackTypeError) {
          String error = result[_resultKeyData] as String;
          onError(error);
        } else if (resultCallbackType == _resultCallbackTypeDismiss) {
          onDismissed();
        } else {
          onError('Unknown callback');
        }
      }
    }
  }
}
