import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/localization/localization.dart';
import '../../../utils/navigation.dart';
import '../../../utils/utils.dart';

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
                  _getHeaderImage(),
                  _getNameTextField(),
                  _getEmailTextField(),
                  _getMobileTextField(),
                  _getPasswordTextField(),
                  _getConfirmPasswordTextField(),
                  _getTermsAndCondition(),
                  _getSignUpButton(),
                  _txtSignedInOption(),
                  _getSocialButton(),
                  _getLogin()
                ],
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
            child: Text("Get Started",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontFamily: "Cocogoose-Regular")),
          ),
        )
      ]);

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
        style: TextStyle(
            fontSize: 15.0,
            color: Color(0xFF262261),
            fontFamily: "Comfortaa-Medium"),
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
        style: TextStyle(
            fontSize: 15.0,
            color: Color(0xFF262261),
            fontFamily: "Comfortaa-Medium"),
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
        style: TextStyle(
            fontSize: 15.0,
            color: Color(0xFF262261),
            fontFamily: "Comfortaa-Medium"),
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

  Widget _getSignUpButton() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.all(20),
      child: RaisedButton(
        color: Color(0xFFF05A28),
        textColor: Colors.white,
        elevation: 1.0,
        onPressed: _registerPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
        ),
        child: Text(
          "Sign Up",
          style: TextStyle(fontSize: 15.0, fontFamily: "Comfortaa-Bold"),
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
        style: TextStyle(
            fontSize: 15.0,
            color: Color(0xFF262261),
            fontFamily: "Comfortaa-Medium"),
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
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFFB451), width: 2),
          ),
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
        style: TextStyle(
            fontSize: 15.0,
            color: Color(0xFF262261),
            fontFamily: "Comfortaa-Medium"),
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
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFFB451), width: 2),
          ),
        ),
        onSaved: (value) {
          _confirmPassword = value;
        },
        obscureText: _confirmPasswordVisible,
      ),
    );
  }

  bool agree = false;

  Widget _getTermsAndCondition() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Column(
        children: [
          Row(children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: InkWell(
                onTap: () {
                  setState(() {
                    agree = !agree;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xB3262261), width: 1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: agree
                      ? Icon(Icons.check, size: 17.0, color: Color(0xB3262261))
                      : Icon(
                          null,
                          size: 17.0,
                        ),
                ),
              ),
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          "By signing up you have read and agree to the Skillsture ",
                      style: TextStyle(
                          color: Color(0xB3262261),
                          fontSize: 14.0,
                          fontFamily: "Comfortaa-Medium"),
                    ),
                    TextSpan(
                      text: "Term & Conditions",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xFFF05A28),
                          fontSize: 14.0,
                          fontFamily: "Comfortaa-Medium"),
                    )
                  ],
                ),
              ),
            )
          ]),
        ],
      ),
    );
  }

  Widget _getSocialButton() => Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 50,
              child: RaisedButton(
                color: Colors.white,
                textColor: Colors.white,
                elevation: 1.0,
                onPressed: _loginPressed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/ic_google.png',
                      width: 18.0,
                      height: 18.0,
                    ),
                    Text(
                      "Google",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Comfortaa-Bold",
                          color: Color(0xFF262261)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text("    "),
          Expanded(
            child: Container(
              height: 50,
              child: RaisedButton(
                color: Colors.white,
                textColor: Colors.white,
                elevation: 1.0,
                onPressed: _loginPressed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/ic_facebook.png',
                      width: 18.0,
                      height: 18.0,
                    ),
                    Text(
                      "Facebook",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Comfortaa-Bold",
                          color: Color(0xFF262261)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ));

  Widget _getLogin() => Container(
        margin: const EdgeInsets.all(10),
        child: FlatButton(
          padding: const EdgeInsets.all(10),
          onPressed: _loginPressed,
          child: RichText(
            text: TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              children: <TextSpan>[
                TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                      color: Color(0xFF262261),
                      fontSize: 14.0,
                      fontFamily: "Comfortaa-Medium.ttf"),
                ),
                TextSpan(
                  text: "Login",
                  style: TextStyle(
                      color: Color(0xFFF05A28),
                      fontSize: 14.0,
                      fontFamily: "Comfortaa-Medium.ttf"),
                )
              ],
            ),
          ),
        ),
        /* child: Text(Localization.of(context).signIn,
              style: TextStyle(
                  color: Color(0xFF262261),
                  fontSize: 14.0,
                  fontFamily: "Comfortaa-Medium")),
        ),*/
      );

  Widget _txtSignedInOption() => Row(children: <Widget>[
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(left: 25.0, right: 20.0),
              child: Divider(
                color: Color(0xB3262261),
                height: 36,
              )),
        ),
        Text("Or sign in with",
            style: TextStyle(
                color: Color(0xB3262261),
                fontSize: 14.0,
                fontFamily: "Comfortaa-Regular")),
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(left: 20.0, right: 25.0),
              child: Divider(
                color: Color(0xB3262261),
                height: 36,
              )),
        ),
      ]);

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

  void _loginPressed() {
    NavigationUtils.push(context, routeLogin);
  }
}
