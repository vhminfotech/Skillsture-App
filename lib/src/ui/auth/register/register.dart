import 'package:flutter/material.dart';

import '../../../utils/localization/localization.dart';
import '../../../utils/utils.dart';
import '../../../widgets/app_logo.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  bool _passwordVisible;
  bool _confirmPasswordVisible;
  final GlobalKey<FormState> _key = GlobalKey();

  String _name;
  String _email;
  String _mobile;
  String _password;
  String _confirmPassword;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
    _confirmPasswordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /*appBar: AppBar(
          title: Text(Localization.of(context).signInTitle),
//          backgroundColor: Colors.white,
        ),*/
        body: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.always,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AppLogo(),
                  _getNameTextField(),
                  _getEmailTextField(),
                  _getMobileTextField(),
                  _getPasswordTextField(),
                  _getConfirmPasswordTextField(),
                  _getSignInButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getAppLogo() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),
        child: FlutterLogo(
          size: 200,
        ),
      ),
    );
  }

  Widget _getEmailTextField() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      margin: const EdgeInsets.only(top: 12),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: _emailFocus,
        decoration: Utils.styleInputDecoration(Localization.of(context).email),
        validator: (value) {
          return Utils.isValidEmail(context, value);
        },
        onSaved: (value) {
          _email = value;
        },
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _getMobileTextField() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      margin: const EdgeInsets.only(top: 12),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: _mobileFocus,
        decoration: Utils.styleInputDecoration(Localization.of(context).mobile),
        maxLength: 10,
        validator: (value) {
          return Utils.isEmpty(
            context,
            value,
            Localization.of(context).msgEnterMobile,
          );
        },
        onSaved: (value) {
          _mobile = value;
        },
        keyboardType: TextInputType.phone,
      ),
    );
  }

  Widget _getNameTextField() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: _nameFocus,
        decoration: Utils.styleInputDecoration(Localization.of(context).name),
        validator: (value) {
          return Utils.isEmpty(
            context,
            value,
            Localization.of(context).msgEnterName,
          );
        },
        onSaved: (value) {
          _name = value;
        },
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget _getSignInButton() {
    return Container(
      width: 200,
      height: 50,
      margin: EdgeInsets.all(20),
      child: RaisedButton(
        color: Colors.indigo,
        textColor: Colors.white,
        elevation: 1.0,
        child: Text(
          Localization.of(context).signInTitle,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: _registerPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }

  Widget _getPasswordTextField() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: _passwordFocus,
        decoration: InputDecoration(
          labelText: Localization.of(context).password,
          labelStyle: Utils.styleTextStyleTextField(),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          border: OutlineInputBorder(),
        ),
        onSaved: (value) {
          _password = value;
        },
        obscureText: _passwordVisible,
      ),
    );
  }

  Widget _getConfirmPasswordTextField() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        focusNode: _confirmPasswordFocus,
        decoration: InputDecoration(
          labelText: Localization.of(context).confirmPassword,
          labelStyle: Utils.styleTextStyleTextField(),
          suffixIcon: IconButton(
            icon: Icon(
              _confirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                _confirmPasswordVisible = !_confirmPasswordVisible;
              });
            },
          ),
          border: OutlineInputBorder(),
        ),
        onSaved: (value) {
          _confirmPassword = value;
        },
        obscureText: _confirmPasswordVisible,
      ),
    );
  }

  void _registerPressed() {
    if (_key.currentState.validate()) {
      _key.currentState.save();

      print(_name);
      print(_email);
      print(_password);
      print(_mobile);
      print(_confirmPassword);
    }
  }
}
