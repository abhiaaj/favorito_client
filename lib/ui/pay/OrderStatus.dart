import 'package:favorito_user/ui/BottomNavigationPage.dart';
import 'package:favorito_user/ui/home/Home.dart';
import 'package:favorito_user/utils/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class OrderStatus extends StatefulWidget {
  var message;
  var order_id;
  var payment_id;
  var icon;
  var payment_method;
  //const OrderStatus({Key key}) : super(key: key);
  OrderStatus(
      {this.message,
      this.order_id,
      this.payment_id,
      this.icon,
      this.payment_method});
  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {},
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  height: 240,
                  width: 350,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Order Id:",
                                  style: TextStyle(color: Colors.black)),
                              Text(widget.order_id ?? "",
                                  style: TextStyle(color: Colors.black)),
                              Text(widget.order_id ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(fontSize: 14)),
                            ],
                          ),
                          Visibility(
                            visible: widget.payment_method == 'Online',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Transaction Id:",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(widget.payment_id ?? "Declined",
                                    style: TextStyle(color: Colors.black)),
                                Text("Transaction Id:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(fontSize: 16)),
                                Text(widget.payment_id ?? "Declined",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(fontSize: 14)),
                              ],
                            ),
                          ),
                          Icon(
                            widget.icon,
                            size: 50,
                            color: widget.message == 'Payment Failed'
                                ? myRed
                                : myGreenDark,
                          ),
                          Text(
                            widget.message,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    color: widget.message == 'Payment Failed'
                                        ? myRed
                                        : myGreenDark,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home,
                      size: 40,
                      color: myRed,
                    ),
                    Text(
                      "Back to Home",
                      style:
                          TextStyle(color: myRed, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
