import 'package:flutter/material.dart';

import '../../screens/splash.dart';
import '../auth/ui/checkyourmail/check_your_mail.dart';
import '../auth/ui/forgotpassword/forgot_password.dart';
import '../auth/ui/login/login.dart';
import '../auth/ui/register/register.dart';
import '../homepage/ui/home_screen.dart';
import '../utils/constants.dart';

class NavigationUtils {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case routeRegister:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case routeLogin:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case routeLaunch:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case routeForgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case routeCheckYourMail:
        return MaterialPageRoute(builder: (_) => CheckYourMailScreen());
      case routeHomePage:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return _errorRoute(" Comming soon...");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('Error')),
          body: Center(child: Text(message)));
    });
  }

  static void pushReplacement(BuildContext context, String routeName,
      {Object arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> push(BuildContext context, String routeName,
      {Object arguments}) {
    return Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static void pop(BuildContext context, {dynamic args}) {
    Navigator.of(context).pop(args);
  }

  static Future<dynamic> pushAndRemoveUntil(
      BuildContext context, String routeName,
      {Object arguments}) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }
}
