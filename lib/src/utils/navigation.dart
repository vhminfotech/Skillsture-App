import 'package:flutter/material.dart';

import '../ui/auth/checkyourmail/check_your_mail.dart';
import '../ui/auth/forgotpassword/forgot_password.dart';
import '../ui/auth/login/login.dart';
import '../ui/auth/register/register.dart';
import '../ui/auth/splash.dart';
import '../ui/home/explore/explore_screen.dart';
import '../ui/home/homepage/home_screen.dart';
import 'constants.dart';

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
      case routeExplorePage:
        return MaterialPageRoute(builder: (_) => ExploreScreen());
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
