import 'package:flutter/material.dart';

import '../../../apis/api_manager.dart';
import '../../../apis/error_model.dart';
import '../../../utils/app_config.dart';
import '../../../utils/constants.dart';
import '../../../utils/dialog_utils.dart';
import '../../../utils/localization/localization.dart';
import '../../../utils/navigation.dart';
import '../../../utils/progress_dialog.dart';
import '../../../utils/utils.dart';
import '../../../widgets/app_logo.dart';

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
          appBar: AppBar(
            title: Text(apiBaseUrl),
          ),
          body: Form(
            key: _key,
            autovalidateMode: AutovalidateMode.always,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AppLogo(),
                  _getEmailTextField(),
                  _getPasswordTextField(),
                  _getForgotPasswordButton(),
                  _getLoginButton(),
//                  _getSocialButton(),
                  _getAccountRegister(),
//                  _buildBody(context),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _getEmailTextField() => Container(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: TextFormField(
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
            onPressed: () {},
            child: Text(
              Localization.of(context).forgotPassword,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      );

//  Widget _getSocialButton() => Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[
//        Container(
//          margin: const EdgeInsets.all(10),
//          padding: const EdgeInsets.all(10),
//          child: Image.asset('assets/images/ic_google.png'),
//        ),
//        Container(
//          margin: const EdgeInsets.all(10),
//          padding: const EdgeInsets.all(10),
//          child: Image.asset('assets/images/ic_facebook.png'),
//        ),
//      ],
//    );

  Widget _getAccountRegister() => Container(
        margin: const EdgeInsets.all(10),
        child: FlatButton(
          padding: const EdgeInsets.all(10),
          onPressed: _registerPressed,
          child: Text(Localization.of(context).signIn),
        ),
      );

  Widget _getLoginButton() => Container(
        width: 200,
        height: 50,
        margin: const EdgeInsets.all(20),
        child: RaisedButton(
          color: Colors.indigo,
          textColor: Colors.white,
          elevation: 1.0,
          onPressed: _loginPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Text(
            Localization.of(context).loginTitle,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  Widget _getPasswordTextField() => Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        child: TextFormField(
          textInputAction: TextInputAction.done,
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
            border: const OutlineInputBorder(),
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
    if (_key.currentState.validate()) {
      _key.currentState.save();
      DialogUtils.showAlertDialog(
          context,  'Are you sure you want to Accept?');
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
    });
  }

  void _registerPressed() {
    NavigationUtils.push(context, routeRegister);
  }
}
