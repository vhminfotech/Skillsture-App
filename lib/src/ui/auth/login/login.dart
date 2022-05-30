import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/localization/localization.dart';
import '../../../utils/navigation.dart';
import '../../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//  AuthProvider _authProvider;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _passwordVisible;
  final GlobalKey<FormState> _key = GlobalKey();

  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
//    _authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          /*appBar: AppBar(
            title: Text(apiBaseUrl),
          ),*/
          body: Form(
            key: _key,
            autovalidateMode: AutovalidateMode.always,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _getHeaderImage(),
                  _getEmailTextField(),
                  _getPasswordTextField(),
                  _getForgotPasswordButton(),
                  _getLoginButton(),
                  _txtSignedInOption(),
                  _getSocialButton(),
                  _getAccountRegister(),
//                  _buildBody(context),
                ],
              ),
            ),
          ),
        ),
      );

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
            child: Text("Welcome",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontFamily: "Cocogoose-Regular")),
          ),
        )
      ]);

  Widget _getEmailTextField() => Container(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: TextFormField(
          style: TextStyle(
              fontSize: 15.0,
              color: Color(0xFF262261),
              fontFamily: "Comfortaa-Medium"),
          textInputAction: TextInputAction.next,
          focusNode: _emailFocus,
          decoration:
              Utils.styleInputDecoration(Localization.of(context).email),
          validator: (value) => Utils.isValidEmail(context, value),
          onSaved: (value) {
            _email = value;
          },
          keyboardType: TextInputType.emailAddress,
        ),
      );

  Widget _getForgotPasswordButton() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            onPressed: _forgotPasswordPressed,
            child: Text(
              Localization.of(context).forgotPassword,
              style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xB3262261),
                  fontFamily: "Comfortaa-Medium"),
            ),
          ),
        ],
      );

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

  Widget _getAccountRegister() => Container(
        margin: const EdgeInsets.all(10),
        child: FlatButton(
          padding: const EdgeInsets.all(10),
          onPressed: _registerPressed,
          child: RichText(
            text: TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              children: <TextSpan>[
                TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(
                      color: Color(0xFF262261),
                      fontSize: 14.0,
                      fontFamily: "Comfortaa-Medium"),
                ),
                TextSpan(
                  text: " Sign Up",
                  style: TextStyle(
                      color: Color(0xFFF05A28),
                      fontSize: 14.0,
                      fontFamily: "Comfortaa-Medium"),
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

  Widget _getLoginButton() => Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.all(20),
        child: RaisedButton(
          color: Color(0xFFF05A28),
          textColor: Colors.white,
          elevation: 1.0,
          onPressed: _loginPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.5),
          ),
          child: Text(
            Localization.of(context).loginTitle,
            style: TextStyle(fontSize: 15.0, fontFamily: "Comfortaa-Bold"),
          ),
        ),
      );

  Widget _getPasswordTextField() => Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        child: TextFormField(
          style: TextStyle(
              fontSize: 15.0,
              color: Color(0xFF262261),
              fontFamily: "Comfortaa-Medium"),
          textInputAction: TextInputAction.done,
          focusNode: _passwordFocus,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFB451), width: 2),
            ),
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
            // border: const OutlineInputBorder(),
          ),
          onSaved: (_) {
            _password = _;
          },
          obscureText: _passwordVisible,
          onFieldSubmitted: (_) {
            _passwordFocus.unfocus();
          },
        ),
      );

  void _loginPressed() {
    NavigationUtils.push(context, routeHomePage);

    /*if (_key.currentState.validate()) {
      _key.currentState.save();
      DialogUtils.showAlertDialog(context, 'Are you sure you want to Accept?');
    }
//    _authProvider.login("vparking", "Ms@12345");
    ProgressDialogUtils.showProgressDialog(context);
    ApiManager().login(_email, _password).then((value) {
      debugPrint(value.data.token);
      ProgressDialogUtils.dismissProgressDialog();
    }).catchError((dynamic e) {
      if (e is ErrorModel) {
        debugPrint(e.error);
      }
      ProgressDialogUtils.dismissProgressDialog();
    });*/
  }

  void _registerPressed() {
    NavigationUtils.push(context, routeRegister);
  }

  void _forgotPasswordPressed() {
    NavigationUtils.push(context, routeForgotPassword);
  }
}
