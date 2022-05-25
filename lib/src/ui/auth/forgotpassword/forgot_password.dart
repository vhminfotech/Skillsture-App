import 'package:flutter/material.dart';
import '../../../utils/localization/localization.dart';
import '../../../widgets/app_logo.dart';

class ForgotPasswordScreen extends StatelessWidget {

  final FocusNode _emailFocus = FocusNode();

  final GlobalKey<FormState> _key = GlobalKey();

  String _email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(Localization.of(context).loginTitle),
        ),
        body: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.always,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AppLogo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
