import 'package:favorito_user/component/EditTextComponent.dart';
import 'package:favorito_user/config/SizeManager.dart';
import 'package:favorito_user/ui/Signup/SignupProvider.dart';
import 'package:favorito_user/ui/chat/LoginPage.dart';
import 'package:favorito_user/utils/MyColors.dart';
import 'package:favorito_user/utils/Regexer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Signup extends StatelessWidget {
  SignupProvider vaTrue;
  SignupProvider spFalse;
  SizeManager sm;
  @override
  Widget build(BuildContext context) {
    sm = SizeManager(context);
    vaTrue = Provider.of<SignupProvider>(context, listen: true);
    spFalse = Provider.of<SignupProvider>(context, listen: false);
    vaTrue.setContext(context);
    return WillPopScope(
        onWillPop: () {
          vaTrue.allClear();
          Navigator.pop(context);
        },
        child: SafeArea(
            child: Scaffold(
                key: vaTrue.scaffoldKey,
                body: Container(
                    height: sm.h(100),
                    width: sm.w(100),
                    padding: EdgeInsets.symmetric(horizontal: sm.w(10)),
                    decoration: BoxDecoration(color: myBackGround),
                    child: ListView(shrinkWrap: true, children: [
                      Padding(
                          padding: EdgeInsets.only(top: sm.h(1)),
                          child: SvgPicture.asset(
                              'assets/icon/signup_image.svg',
                              height: sm.h(20),
                              fit: BoxFit.fitHeight)),
                      Padding(
                        padding: EdgeInsets.only(top: sm.h(2)),
                        child: Text(
                          "Welcome.",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      Container(
                        child: Builder(
                            builder: (context) => Form(
                                key: spFalse.formKey,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i < spFalse.title.length;
                                          i++)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: EditTextComponent(
                                            controller:
                                                vaTrue.acces[i].controller,
                                            title: vaTrue.title[i],
                                            hint: vaTrue.title[i],
                                            errorColor: vaTrue.errorColor[i],
                                            myOnChanged: (s) {
                                              vaTrue.verifyMobile = 'verify';
                                              if (i == 6) {}
                                              spFalse.onChange(i);
                                            },
                                            suffixTap: () {
                                              print("sdfsdfs");
                                              if (i == 3) {
                                                if (vaTrue.acces[3].controller
                                                        .text.length >=
                                                    5) {
                                                  vaTrue.checkIdClicked(i);
                                                }
                                              } else if (i == 1) {
                                                if (mobileRegex.hasMatch(vaTrue
                                                    .acces[i]
                                                    .controller
                                                    .text)) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChatLogin(
                                                                  mobileNo: vaTrue
                                                                      .acces[1]
                                                                      .controller
                                                                      .text,
                                                                  imIn:
                                                                      false))).whenComplete(
                                                      () {
                                                    vaTrue.checkId();
                                                  });
                                                  vaTrue.notifyListeners();
                                                } else {
                                                  vaTrue.acces[i].error =
                                                      'Invalid contact number..';
                                                  vaTrue.notifyListeners();
                                                }
                                              }
                                            },
                                            prefixtxt: i == 3 ? "@" : '',
                                            suffixTxt: i == 3
                                                ? vaTrue.getCheckId()
                                                : '',
                                            error: vaTrue.acces[i].error,
                                            security: false,
                                            valid: true,
                                            maxLines: 1,
                                            formate: (i == 1 || i == 2)
                                                ? FilteringTextInputFormatter
                                                    .digitsOnly
                                                : FilteringTextInputFormatter
                                                    .singleLineFormatter,
                                            maxlen: i == 1
                                                ? 10
                                                : i == 2
                                                    ? 6
                                                    : i == 3
                                                        ? 15
                                                        : 50,
                                            keyboardSet: i == 3
                                                ? TextInputType.emailAddress
                                                : (i == 1 || i == 2)
                                                    ? TextInputType.phone
                                                    : TextInputType.text,
                                            prefixIcon: vaTrue.prefix[i],
                                          ),
                                        ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 50),
                                        child: Text(
                                          vaTrue.checkIdMessage,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  fontSize: 16, color: myRed),
                                        ),
                                      ),
                                      tcp(
                                        key: key,
                                        sm: sm,
                                        newValue: vaTrue.newValue,
                                        newValue1: vaTrue.newValue1,
                                        returnValue: (a, b) {
                                          vaTrue.newValue = a;
                                          vaTrue.newValue1 = b;
                                        },
                                      ),
                                    ]))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: sm.h(4)),
                        child: NeumorphicButton(
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.convex,
                                // depth: 4,
                                lightSource: LightSource.topLeft,
                                color: myBackGround,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.all(Radius.circular(24.0)))),
                            margin: EdgeInsets.only(
                                left: sm.w(10), right: sm.w(10)),
                            onPressed: () => vaTrue.funSubmit(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Center(
                              child: Text("Submit",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: myRed)),
                            )),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: sm.h(4)),
                          child: Text(
                            "Already have an account?",
                            style: TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 16),
                          ),
                        ),
                      ),
                      Center(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: sm.h(1), bottom: sm.h(8)),
                              child: InkWell(
                                  onTap: () {
                                    vaTrue.allClear();
                                    Navigator.pop(context);
                                    // Navigator.of(context).pushNamed('/login');
                                  },
                                  child: Text("Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: myRed)))))
                    ])))));
  }
}

class tcp extends StatefulWidget {
  tcp({
    Key key,
    @required this.sm,
    @required this.newValue,
    @required this.newValue1,
    @required this.returnValue,
  }) : super(key: key);

  final SizeManager sm;
  bool newValue;
  bool newValue1;
  Function returnValue;
  @override
  _tcpState createState() => _tcpState();
}

class _tcpState extends State<tcp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: widget.sm.h(1)),
        child: Column(children: [
          t_c(
            isChecked: widget.newValue,
            title:
                "By continuing, you agree to Favorito's Terms of Service and acknowledge Favorito's Privacy Policy",
            function: (v) {
              print("${widget.key}");
              setState(() {
                widget.newValue = v;
                widget.returnValue(widget.newValue, widget.newValue1);
              });
            },
          ),
          t_c(
              isChecked: widget.newValue1,
              title: "Reach me on whatsapp",
              function: (vv) {
                setState(() {
                  widget.newValue1 = vv;
                  widget.returnValue(widget.newValue, widget.newValue1);
                });
              })
        ]));
  }
}

class t_c extends StatelessWidget {
  final isChecked;
  final title;
  Function function;
  t_c({Key key, this.isChecked, this.title, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Checkbox(value: isChecked, onChanged: function)),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.4,
                  color: myGrey),
            ),
          )
        ],
      ),
    );
  }
}
