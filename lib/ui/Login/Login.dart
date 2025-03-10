import 'package:favorito_user/component/EditTextComponent.dart';
import 'package:favorito_user/config/SizeManager.dart';
import 'package:favorito_user/services/APIManager.dart';
import 'package:favorito_user/ui/Login/LoginController.dart';
import 'package:favorito_user/utils/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isFirst = false;
  LoginProvider vaTrue;

  @override
  Widget build(BuildContext context) {
    SizeManager sm = SizeManager(context);
    vaTrue = Provider.of<LoginProvider>(context, listen: true);
    if (isFirst) {}
    vaTrue.getDeviceToken();
    return WillPopScope(
        onWillPop: () => APIManager.onWillPop(context),
        child: Scaffold(
            key: _scaffoldKey,
            body: Padding(
                padding: EdgeInsets.only(
                  left: sm.w(10),
                  right: sm.w(10),
                  top: sm.h(5),
                ),
                child: ListView(shrinkWrap: true, children: [
                  SvgPicture.asset('assets/icon/login_image.svg',
                      height: sm.h(34), fit: BoxFit.fill),
                  SizedBox(height: sm.h(2)),
                  Text("Welcome Back.",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4,
                          fontSize: 28)),
                  SizedBox(height: sm.h(2)),
                  Builder(
                      builder: (context) => Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(children: [
                            for (int i = 0;
                                i <
                                    (vaTrue.title.length -
                                        (vaTrue.getIsPass() ? 0 : 1));
                                i++)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: EditTextComponent(
                                  controller: vaTrue.controller[i],
                                  hint: vaTrue.title[i],
                                  security: i == 1 ? true : false,
                                  valid: true,
                                  suffixTap: () {},
                                  suffixTxt: '',
                                  maxLines: 1,
                                  formate: FilteringTextInputFormatter
                                      .singleLineFormatter,
                                  maxlen: i == 1 ? 12 : 30,
                                  keyboardSet: i == 0
                                      ? TextInputType.emailAddress
                                      : TextInputType.text,
                                  prefixIcon: vaTrue.prefix[i],
                                ),
                              ),
                            Visibility(
                              visible: vaTrue.getIsPass(),
                              child: InkWell(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed('/forgetPassword'),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('Forgot password ?  ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(color: myRed),
                                            textScaleFactor: .8)
                                      ])),
                            )
                          ]))),
                  Padding(
                      padding: EdgeInsets.only(top: sm.h(5)),
                      child: NeumorphicButton(
                        style: NeumorphicStyle(
                            // shape: NeumorphicShape.concave,
                            // depth: 11,
                            intensity: 40,
                            surfaceIntensity: -.4,
                            // lightSource: LightSource.topLeft,
                            color: myButtonBackground,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.all(Radius.circular(24.0)))),
                        margin: EdgeInsets.symmetric(horizontal: sm.w(10)),
                        onPressed: () {
                          vaTrue.funSubmit(_formKey, _scaffoldKey);
                        },
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Center(
                            child: Text(vaTrue.getIsPass() ? 'Login' : 'Next',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: myRed))),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: sm.h(4)),
                    child: Row(
                      children: [
                        Expanded(child: Divider()),
                        Text('  OR  ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: myGrey,
                                    fontSize: 16)),
                        Expanded(child: Divider())
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Request for ",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.w300,
                            color: myGrey,
                            fontSize: 16),
                      ),
                      InkWell(
                          onTap: () => vaTrue.setIsPass(!vaTrue.getIsPass()),
                          child: Text(vaTrue.getIsPass() ? 'OTP' : 'Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: myRed)))
                    ],
                  ),
                  Center(
                      child: Padding(
                          padding: EdgeInsets.only(top: sm.h(4)),
                          child: Text("Dont have account yet?",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontWeight: FontWeight.w300,
                                      color: myGrey,
                                      fontSize: 16)))),
                  Center(
                      child: Padding(
                          padding: EdgeInsets.only(bottom: sm.h(4)),
                          child: InkWell(
                              onTap: () =>
                                  Navigator.of(context).pushNamed('/signUp'),
                              child: Text("Sign Up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: myRed)))))
                ]))));
  }
}
