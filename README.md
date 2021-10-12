# Flutter Payhere Packages
### Multiplatform packages for payhere SDKs ###
DO NOT IMPORT THIS FOR YOUR PROJECTS.

Instead, see instructions at [https://github.com/iwalpola/flutter_payhere](https://github.com/iwalpola/flutter_payhere)
## note to developers ##
I have modified the payhere_mobilesdk_flutter.
it is here for now : [https://github.com/iwalpola/flutter_payhere](https://github.com/iwalpola/flutter_payhere)

CHANGES to payhere_mobilesdk_flutter:
*uses async instead of .then()
*migrated to platform interface
*renamed library to flutter_payhere so that there are no clashes with
existing production code which use old library

NOTE: the platform interface also currently treats startPayment()
as an async function.