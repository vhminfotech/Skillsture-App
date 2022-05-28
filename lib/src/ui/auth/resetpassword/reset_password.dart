import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/navigation.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordScreen> {
  final FocusNode _emailFocus = FocusNode();

  final GlobalKey<FormState> _key = GlobalKey();

  String _email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.always,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[_getHeaderImage(), _getBody()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getHeaderImage() => Stack(children: <Widget>[
        Image.asset(
          'assets/images/header.jpg',
          width: double.infinity,
          height: (MediaQuery.of(context).size.height) / 4,
          fit: BoxFit.cover,
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          height: (MediaQuery.of(context).size.height) / 5,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text("Check Your \nEmail",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontFamily: "Cocogoose-Regular")),
          ),
        )
      ]);

  Widget _getBody() => Container(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 50),
              height: 60,
              width: 60,
              child: RaisedButton(
                elevation: 0,
                color: Color(0x4DF05A28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.5),
                ),
                onPressed: () {},
                child: Image.asset(
                  'assets/images/ic_mail.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Text(
                "We’ve sent you an email to",
                style: TextStyle(
                    color: Color(0xFF262261),
                    fontSize: 14.0,
                    fontFamily: "Comfortaa-Medium"),
              ),
            ),
            Container(
              child: Text(
                "johndoe@gmail.com",
                style: TextStyle(
                    color: Color(0xFF262261),
                    fontSize: 14.0,
                    fontFamily: "Comfortaa-Bold"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Text(
                "Click the link in the email to reset your password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF262261),
                    fontSize: 14,
                    fontFamily: "Comfortaa-Regular"),
              ),
            ),
          ],
        ),
      );

  void _loginPressed() {
    NavigationUtils.push(context, routeLogin);
  }

  void _resetPasswordPressed() {
    NavigationUtils.push(context, routeResetPassword);
  }
}
