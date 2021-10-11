import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_payhere_flutter.dart';

//typedef
typedef PayHereOnCompletedHandler = void Function(String paymentId);
typedef PayHereOnErrorHandler = void Function(String error);
typedef PayHereOnDismissedHandler = void Function();

/// The interface that implementations of payhere_flutter must implement.
///
/// Platform implementations should extend this class rather than implement it as `payhere_flutter`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
/// [PayHerePlatform] methods.
abstract class PayHerePlatform extends PlatformInterface {
  /// Constructs a PayHerePlatform.
  PayHerePlatform() : super(token: _token);

  static final Object _token = Object();

  //Defaulting to an implementation backed by a MethodChannel means that the
  //existing Android and iOS implementations will continue to work by default
  static PayHerePlatform _instance = MethodChannelPayHere();

  /// The default instance of [PayHerePlatform] to use.
  ///
  /// Defaults to [MethodChannelUrlLauncher].
  static PayHerePlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [PayHerePlatform] when they register themselves.
  static set instance(PayHerePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Launches the given [url]. Completes to [true] if the launch was successful.
  Future<void> startPayment(
      Map paymentObject,
      PayHereOnCompletedHandler onCompleted,
      PayHereOnErrorHandler onError,
      PayHereOnDismissedHandler onDismissed) {
    throw UnimplementedError('startPayment() has not been implemented.');
  }
}
