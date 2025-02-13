import 'package:favorito_user/services/APIManager.dart';
import 'package:favorito_user/ui/pay/OrderStatus.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class PayHome extends StatefulWidget {
  var options;
  GlobalKey<ScaffoldState> key;
  PayHome({this.options, this.key});
  // const PayHome({ Key? key }) : super(key: keyStatelessWidget);

  @override
  _PayHomeState createState() => _PayHomeState();
}

class _PayHomeState extends State<PayHome> {
  Razorpay _razorpay = Razorpay();
  void paymentStart() {
    try {
      _razorpay.open(widget.options);
    } catch (e) {
      processPayment(widget.options);
    }
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    paymentStart();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            paymentStart();
          },
          child: Text(
            "Checkout",
            style: Theme.of(context).textTheme.headline6.copyWith(),
          ),
        ),
      ),
    );
  }

  processPayment(opt) {
    _razorpay.open(opt);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("I am here 1");
    print("${response.paymentId}");
    print(response.orderId);
    Map _map = {
      "order_id": widget.options["order_id"],
      "razorpay_order_id": response.orderId,
      "razorpay_payment_id": response.paymentId,
      "razorpay_signature": response.signature
    };
    print("abcd: ${_map.toString()}");
    await APIManager.orderVerify(_map).then((value) {
      if (value.status == 'success') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderStatus(
                      message: value.message,
                      order_id: response.orderId,
                      payment_id: response.paymentId,
                      icon: Icons.tag_faces,
                      payment_method: "Online",
                    )));
      }
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("I am here 2");
    print(
        "response.code:${response.code}\nresponse.message:${response.message}");

    //print("abcd: ${_map.toString()}");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OrderStatus(
                order_id: widget.options["order_id"],
                icon: Icons.mood_bad,
                message: "Payment Failed")));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("I am here 3");
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }
}
