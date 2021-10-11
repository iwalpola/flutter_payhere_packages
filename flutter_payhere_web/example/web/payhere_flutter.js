/**
 * PayHere Flutter Web JS
 * 
 * Glue code for passing variables properly to payhere.js
 */

var payhere_flutter_web = {
    setOnCompleted: function(onCompleted){
        payhere.onCompleted = onCompleted
    },
    setOnDismissed: function(onDismissed){
        payhere.onDismissed = onDismissed
    },
    setOnError: function(onError){
        payhere.onError = onError
    },
    startPayment: function(paymentString){
        try{
            let paymentObj = JSON.parse(paymentString);
            paymentObj['return_url'] = undefined;
            paymentObj['cancel_url'] = undefined;
            payhere.startPayment(paymentObj);
        }
        catch(e){
            this.onError(e);
        }
    }
}