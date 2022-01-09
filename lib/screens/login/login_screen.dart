import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_login/flutter_login.dart';

import 'package:netflux/const.dart';
import 'package:netflux/screens/home/home_screen.dart';
import 'package:netflux/models/user.dart';
import 'package:netflux/daos/user_dao.dart';
import 'package:netflux/utils/custom_route.dart';
import 'package:netflux/utils/color.dart';
import 'package:netflux/utils/validators.dart';
import 'package:netflux/providers/auth.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';
  UserDAO userDAO = UserDAO();

  final inputBorder = BorderRadius.circular(20);

  LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(LoginData data) {
    return userDAO.login(data.name, data.password).then((res) {
      if (!res["status"]) {
        return res["message"];
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    print("disini ${data.name} ${data.password}");
    String name = data.name ?? "";
    String password = data.password ?? "";

    if (name.isEmpty || password.isEmpty) {
      return Future.value("Please fill all the fields");
    }

    return userDAO.register(name, password).then((res) {
      if (!res["status"]) {
        return res["message"];
      }
      return null;
    });
  }

  Future<String?> _signupConfirm(String error, LoginData data) {
    print("another ${data.name} ${data.password}");
    /*return _loginUser(data);*/
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: Constants.appName,
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      navigateBackAfterRecovery: true,
      /*onConfirmRecover: _signupConfirm,*/
      /*onConfirmSignup: _signupConfirm,*/
      loginAfterSignUp: false,
      userType: LoginUserType.name,
      messages: LoginMessages(userHint: 'Username'),
      initialAuthMode: AuthMode.login,
      hideForgotPasswordButton: true,
      theme: LoginTheme(
        primaryColor: mainColor,
        accentColor: mainColor,
        errorColor: Colors.deepOrange,
        pageColorLight: mainColor,
        pageColorDark: darken(mainColor, 0.3),
        logoWidth: 0.80,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontFamily: mainFont,
          letterSpacing: 4,
        ),
        bodyStyle: const TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
        textFieldStyle: TextStyle(
          color: darken(mainColor, 0.5),
          shadows: const [Shadow(color: Colors.yellow, blurRadius: 2)],
        ),
        buttonStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
        cardTheme: CardTheme(
          color: Colors.yellow.shade100,
          elevation: 5,
          margin: const EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.purple.withOpacity(.1),
          contentPadding: EdgeInsets.zero,
          errorStyle: const TextStyle(
            backgroundColor: Colors.orange,
            color: Colors.white,
          ),
          labelStyle: TextStyle(color: darken(mainColor, 0.3)),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: mainColor, width: 4),
            borderRadius: inputBorder,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: mainColor, width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: mainColor, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 5),
            borderRadius: inputBorder,
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.purple,
          backgroundColor: lighten(Colors.pinkAccent, 0.1),
          highlightColor: Colors.lightGreen,
          elevation: 9.0,
          highlightElevation: 6.0,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      userValidator: validateUsername,
      passwordValidator: validatePassword,
      onLogin: (loginData) {
        debugPrint('Login info');
        debugPrint('Name: ${loginData.name}');
        debugPrint('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSignup: (signupData) {
        debugPrint('Signup info');
        debugPrint('Name: ${signupData.name}');
        debugPrint('Password: ${signupData.password}');

        return _signupUser(signupData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(FadePageRoute(
          builder: (context) => const HomeScreen(),
        ));
      },
      onRecoverPassword: (_) {},
      showDebugButtons: false,
    );
  }
}
