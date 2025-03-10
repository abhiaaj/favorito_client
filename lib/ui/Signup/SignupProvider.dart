import 'package:bot_toast/bot_toast.dart';
import 'package:favorito_user/Providers/BaseProvider.dart';
import 'package:favorito_user/component/PinCodeVerificationScreen.dart';
import 'package:favorito_user/services/APIManager.dart';
import 'package:favorito_user/ui/chat/LoginPage.dart';
import 'package:favorito_user/utils/MyColors.dart';
import 'package:favorito_user/utils/Prefs.dart';
import 'package:favorito_user/utils/Regexer.dart';
import 'package:favorito_user/utils/Validator.dart';
import 'package:favorito_user/utils/acces.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupProvider extends BaseProvider {
  Validator validator = Validator();

  List<Acces> acces = [for (int i = 0; i < 8; i++) Acces()];
  ProgressDialog pr;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String _checkId = 'verify';
  String verifyMobile = 'verify';
  String _checkIdMessage = null;
  bool uniqueId = false;
  bool uniqueMobile = false;
  bool uniqueEmail = false;
  bool newValue = false;
  bool newValue1 = false;
  GlobalKey key = GlobalKey();
  SharedPreferences preferences;
  List<String> title = ['Full Name', 'Phone', 'Postal', 'Unique Id'];

  List<String> prefix = ['name', 'phone', 'postal', 'name'];
  List<Color> errorColor = [null, null, null, null, null, null, null];
  SignupProvider() {
    initCall();
  }
  initCall() async {
    preferences = await SharedPreferences.getInstance();
  }

  void decideit() async {
    String token = await Prefs.token;
    print("token : $token");
    if (token.length < 10 || token == null || token.isEmpty || token == "")
      Navigator.of(context).pushNamed('/login');
  }

  BuildContext context;
  setContext(BuildContext context) {
    this.context = context;
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false)
      ..style(message: 'Please wait..');
  }

  funSubmit() async {
    // verifyMobile

    // if (verifyMobile == 'verify') {
    //   snackBar('Please verify contact number..', scaffoldKey);
    //   return;
    // }
    //
    if (_checkId == 'verify') {
      snackBar('Please verify id..', scaffoldKey);
      return;
    }
    print("$newValue");
    acces[0].error = validator.validateFullName(acces[0].controller.text);
    acces[1].error = validator.validateMobile(acces[1].controller.text);
    acces[2].error = validator.validatePin(acces[2].controller.text);
    acces[3].error = validator.validateId(acces[3].controller.text);

    notifyListeners();
    if (acces[0].error == null &&
        acces[1].error == null &&
        acces[2].error == null &&
        acces[3].error == null &&
        uniqueId &&
        uniqueMobile) {
      if (newValue) {
        Map _map = {
          "full_name": acces[0].controller.text.trim(),
          "phone": acces[1].controller.text.trim(),
          "postal_code": acces[2].controller.text.trim(),
          "profile_id": "@" + acces[3].controller.text.trim(),
          "reach_whatsapp": newValue1 ? 1 : 0,
          "fb_key": preferences.getString('firebaseId')
        };
        print("map:${_map.toString()}");

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatLogin(
                      mobileNo: acces[1].controller.text,
                    )));
        // await APIManager.register(_map, scaffoldKey).then((value) {
        //   snackBar(value.message, scaffoldKey);
        //   if (value.status == "success") {
        //     acces[0].controller.text = '';
        //     acces[1].controller.text = '';
        //     acces[2].controller.text = '';
        //     acces[3].controller.text = '';
        //     newValue = false;
        //     newValue1 = false;

        //     Navigator.pop(context);
        //     // Navigator.of(context).pushNamed('/login');
        //   }
        // }
        // );
      } else {
        BotToast.showText(text: "Please check T&C.");
      }
    } else {
      print("uniqueId:$uniqueId");
    }
  }

  checkIdClicked(int _index) async {
    print("dddddprofile_id: ${acces[_index].controller.text}");

    await APIManager.checkId(
            {"profile_id": acces[_index].controller.text}, scaffoldKey)
        .then((value) {
      if (value.status == 'success') {
        if (value.data[0].isExist != 0) {
          acces[_index].error = value.message;
          uniqueId = false;

          errorColor[_index] = null;
        } else {
          _checkId = 'verified';
          uniqueId = true;
          acces[_index].error = null;
          errorColor[_index] = myGreenDark;
        }
        acces[_index].error = value.message;
      }
      notifyListeners();
    });
  }

  onChange(int _index) async {
    print(_index);
    switch (_index) {
      case 0:
        {
          if ((acces[_index].controller.text.isEmpty)) {
            acces[_index].error = 'Field required';
            errorColor[_index] = myRed;
          } else {
            acces[_index].error = null;
          }
          notifyListeners();
        }
        break;

      case 1:
        {
          if (mobileRegex.hasMatch(acces[_index].controller.text))
            CheckMobileNiumber(_index);
          else {
            acces[_index].error = null;
          }
          notifyListeners();
        }
        break;

      // case 3:
      //   {
      //     if (passwordRegex.hasMatch(acces[_index].controller.text))
      //       acces[3].error = null;
      //     else {
      //       acces[_index].error =
      //           validator.validatePassword(acces[_index].controller.text);
      //     }
      //     notifyListeners();
      //   }
      //   break;

      case 2:
        {
          if ((acces[_index].controller.text.isEmpty))
            acces[_index].error = 'Field required';
          else {
            if (acces[_index].controller.text.length == 6) {
              await APIManager.checkPostalCode(
                      {"pincode": acces[_index].controller.text}, scaffoldKey)
                  .then((value) {
                if (value.data.stateName == null)
                  acces[_index].error = value.message;
                else {
                  Prefs.setPOSTEL(int.parse(acces[_index].controller.text));
                  acces[_index].error = null;
                }
              });
            }
          }
          notifyListeners();
        }
        break;

      case 3:
        {
          if (acces[_index].controller.text.isEmpty) {
            acces[_index].error =
                Validator().validateId(acces[_index].controller.text);
            acces[_index].controller.text = '';
          } else if (acces[_index].controller.text.length < 5) {
            acces[_index].error = 'Id should be 5 character long';
            errorColor[_index] = myRed;
          } else
            acces[_index].error = '';
          setCheckId('verify');

          notifyListeners();
        }
        break;
    }
  }

  void CheckMobileNiumber(int _index) async {
    String _text = acces[_index].controller.text;
    await APIManager.checkMobileOrEmail({'api_type': 'mobile', 'mobile': _text})
        .then((value) {
      if (value.status == 'success') {
        print(value.message);
        uniqueMobile = true;
        acces[_index].error = value.data[0].isExist == 1 ? value.message : null;
        notifyListeners();
      } else
        uniqueMobile = false;
    });
  }

  allClear() {
    for (int i = 0; i < acces.length; i++) acces[i] = Acces();

    uniqueId = false;
    uniqueMobile = false;
    uniqueEmail = false;
    newValue = false;
    newValue1 = false;
    _checkId = 'verify';
    notifyListeners();
  }

  String getCheckId() => _checkId;
  void setCheckId(String _val) {
    _checkId = _val;
    notifyListeners();
  }

  String get checkIdMessage => _checkIdMessage ?? '';

  checkId() async {
    if (preferences.getString('firebaseId') != null) {
      verifyMobile = 'verified';
      notifyListeners();
    }
  }
}
