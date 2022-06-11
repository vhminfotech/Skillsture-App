import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../graphqlconfigs/mutation_query.dart';
import '../../../localization/localization.dart';
import '../../../navigation/navigation.dart';
import '../../../utils/constants.dart';
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

  bool agree = false;
  bool _passwordVisible;
  bool _confirmPasswordVisible;
  bool _isPasswordEightDigit;
  bool _isPasswordUpperAndLower;
  bool _isPasswordOneNumberSymbol;
  bool _isPasswordNotEmail;
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
    _isPasswordEightDigit = false;
    _isPasswordUpperAndLower = false;
    _isPasswordOneNumberSymbol = false;
    _isPasswordNotEmail = false;
  }

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
                children: <Widget>[
                  _getHeaderImage(),
                  _getNameTextField(),
                  _getEmailTextField(),
                  _getMobileTextField(),
                  _getPasswordTextField(),
                  _getPasswordValidationField(),
                  _getConfirmPasswordTextField(),
                  _getTermsAndCondition(),
                  Mutation(
                    options: MutationOptions(
                      document: gql(MutationQuery().registeredUser),
                      onCompleted: (dynamic resultData){
                        if(resultData == null){
                          print("Registered Failed");
                          return;
                        }else{
                          print("Registered Token");
                          print(resultData.toString());
                          NavigationUtils.push(context, routeHomePage);
                        }
                      }
                    ),
                    builder: (runMutation, result){
                      return _getSignUpButton(runMutation);
                    },
                  ),
                  //_getSignUpButton(),
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

  Widget _getPasswordValidationField() {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        _rowPasswordField(
            "contains at least 8 characters", _isPasswordEightDigit),
        _rowPasswordField("contains both lowercase and uppercase letters",
            _isPasswordUpperAndLower),
        _rowPasswordField("contains at least one number (0-9) or a symbol",
            _isPasswordOneNumberSymbol),
        _rowPasswordField(
            "does not contain your email address", _isPasswordNotEmail),
      ],
    );
  }

  Widget _rowPasswordField(String label, bool passwordValidation) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        passwordValidation
            ? Container(
                height: 20,
                width: 20,
                child: Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 20,
                ),
              )
            : Container(
                height: 20,
                width: 20,
                child: Icon(
                  Icons.circle,
                  color: Colors.black,
                  size: 7,
                ),
              ),
        SizedBox(
          width: 5,
        ),
        Text(
          label,
          style: Utils.styleTextStylePasswordTextField(),
        )
      ],
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
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: "Cocogoose-Regular")),
          ),
        )
      ]);

  Widget _getEmailTextField() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      margin: const EdgeInsets.only(top: 12),
      child: TextFormField(
        style: TextStyle(
            fontSize: 20.0,
            color: Color(0xFF262261),
            fontFamily: "Comfortaa-Medium"),
        textInputAction: TextInputAction.next,
        focusNode: _emailFocus,
        decoration: Utils.styleInputDecoration(Localization.of(context).email),
        validator: (value) {
          return Utils.isValidEmail(context, value);
        },
        onChanged: (value) {
          _email = value;
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
      child: IntlPhoneField(
        decoration:
          Utils.styleInputDecoration(Localization.of(context).mobile),
        initialCountryCode: 'MY',
        validator: (phone) {
          return Utils.isEmpty(
            context,
            phone.completeNumber,
            Localization.of(context).msgEnterMobile,
          );
        },
        onChanged: (phone) {
          print(phone.completeNumber);
          _mobile = phone.completeNumber;
        },
        onSaved: (phone) {
          _mobile = phone.completeNumber;
        },
      ),
    );
  }


 /* Widget _getMobileTextField() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: CountryCodePicker(
            textStyle: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF262261),
                fontFamily: "Comfortaa-Medium"),
            onChanged: print,
            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            initialSelection: 'MY',
            favorite: ['+60', 'MY'],

            countryFilter: countryList,
            showFlagDialog: false,
            comparator: (a, b) => b.name.compareTo(a.name),
            //Get the country information relevant to the initial selection
            onInit: (code) =>
                print("on init ${code.name} ${code.dialCode} ${code.name}"),
          ),
        ),
        Expanded(
          flex: 3,
          //SizedBox(height: 20.0),
          child: TextFormField(
            style: TextStyle(
                fontSize: 20.0,
                color: Color(0xFF262261),
                fontFamily: "Comfortaa-Medium"),
            textInputAction: TextInputAction.next,
            focusNode: _mobileFocus,
            decoration:
                Utils.styleInputDecoration(Localization.of(context).mobile),
            maxLength: 10,
            validator: (value) {
              return Utils.isEmpty(
                context,
                value,
                Localization.of(context).msgEnterMobile,
              );
            },
            onChanged: (value) {
              _mobile = value;
            },
            onSaved: (value) {
              _mobile = value;
            },
            keyboardType: TextInputType.phone,
          ),
        ),
      ],
    );
  }*/

  Widget _getNameTextField() {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: TextFormField(
        style: TextStyle(
            fontSize: 20.0,
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
        onChanged: (value) {
          _name = value;
        },
        onSaved: (value) {
          _name = value;
        },
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget _getSignUpButton(RunMutation runMutation) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.all(20),
      child: RaisedButton(
        color: Color(0xFFF05A28),
        textColor: Colors.white,
        elevation: 1.0,
        //onPressed: _registerPressed,
        onPressed: (){
          if (_key.currentState.validate()) {

            if(agree == true){
              _key.currentState.save();

              print(_name);
              print(_email);
              print(_password);
              print(_mobile);
              print(_confirmPassword);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Please accept terms & conditions"),
              ));
              print("Please accept terms & conditions");
            }
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
        ),
        child: Text(
          "Sign Up",
          style: TextStyle(fontSize: 16.0, fontFamily: "Comfortaa-Bold"),
        ),
      ),
    );
  }

/*  Widget _getSignUpButton() {
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
          style: TextStyle(fontSize: 16.0, fontFamily: "Comfortaa-Bold"),
        ),
      ),
    );
  }*/

  Widget _getPasswordTextField() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        focusNode: _passwordFocus,
        style: TextStyle(
            fontSize: 20.0,
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
        validator: onValidationPassword,
        onSaved: (value) {
          _password = value;
        },
        onChanged: (password) {
          _password = password;
          onChangePassword(password);
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
            fontSize: 20.0,
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
        validator: (value){
          return Utils.isPasswordMatched(context, value, _password);
        },
        obscureText: _confirmPasswordVisible,
      ),
    );
  }

  Widget _getTermsAndCondition() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, right: 15, top: 5, bottom: 5),
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
                          fontSize: 16.0,
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
                          fontSize: 16.0,
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
                      fontFamily: "Comfortaa-Medium"),
                ),
                TextSpan(
                  text: "Login",
                  style: TextStyle(
                      color: Color(0xFFF05A28),
                      fontSize: 14.0,
                      fontFamily: "Comfortaa-Medium"),
                )
              ],
            ),
          ),
        ),
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

      if(agree == true){
        _key.currentState.save();

        print(_name);
        print(_email);
        print(_password);
        print(_mobile);
        print(_confirmPassword);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please accept terms & conditions"),
        ));
        print("Please accept terms & conditions");
      }
    }
  }

  void _loginPressed() {
    NavigationUtils.push(context, routeLogin);
  }

  void onChangePassword(String password) {
    final upperLowerReg = RegExp(r'[A-Za-z]');
    final numberOrSymbol = RegExp(r'[!@#$%^&*_0-9]');

    setState(() {
      _isPasswordEightDigit = false;
      if (password.length >= 8) {
        _isPasswordEightDigit = true;
      }

      _isPasswordOneNumberSymbol = false;
      if (numberOrSymbol.hasMatch(password)) {
        _isPasswordOneNumberSymbol = true;
      }

      _isPasswordUpperAndLower = false;
      if (upperLowerReg.hasMatch(password)) {
        _isPasswordUpperAndLower = true;
      }

      _isPasswordNotEmail = false;
      if (password != _email) {
        _isPasswordNotEmail = true;
      }
    });
  }

  String onValidationPassword(String password) {

    if (password.isEmpty){
      return "Please enter a password";
    }
/*
    final upperLowerReg = RegExp(r'[A-Za-z]');
    final numberOrSymbol = RegExp(r'[!@#$%^&*_0-9]');

    _isPasswordEightDigit = false;
    _isPasswordOneNumberSymbol = false;
    _isPasswordUpperAndLower = false;
    _isPasswordNotEmail = false;

    if (password.length >= 8) {
      setState(() {
        _isPasswordEightDigit = true;
      });
    }
    if (numberOrSymbol.hasMatch(password)) {
      setState(() {
        _isPasswordOneNumberSymbol = true;
      });
    }
    if (upperLowerReg.hasMatch(password)) {
      setState(() {
        _isPasswordUpperAndLower = true;
      });
    }
    if (password != _email) {
      setState(() {
        _isPasswordNotEmail = true;
      });
    }*/ else {
      return null;
    }
  }
}

void _getRegistrationMutation() {}

final List<String> countryList = [
  'AF',
  'AX',
  'AL',
  'DZ',
  'AS',
  'AD',
  'AO',
  'AI',
  'AQ',
  'AG',
  'AR',
  'AM',
  'AW',
  'AU',
  'AT',
  'AZ',
  'BH',
  'BS',
  'BD',
  'BB',
  'BY',
  'BE',
  'BZ',
  'BJ',
  'BM',
  'BT',
  'BO',
  'BQ',
  'BA',
  'BW',
  'BV',
  'BR',
  'IO',
  'BN',
  'BG',
  'BF',
  'BI',
  'KH',
  'CM',
  'CA',
  'CV',
  'KY',
  'CF',
  'TD',
  'CL',
  'CN',
  'CX',
  'CC',
  'CO',
  'KM',
  'CG',
  'CD',
  'CK',
  'CR',
  'CI',
  'HR',
  'CU',
  'CW',
  'CY',
  'CZ',
  'DK',
  'DJ',
  'DM',
  'DO',
  'EC',
  'EG',
  'SV',
  'GQ',
  'ER',
  'EE',
  'ET',
  'FK',
  'FO',
  'FJ',
  'FI',
  'FR',
  'GF',
  'PF',
  'TF',
  'GA',
  'GM',
  'GE',
  'DE',
  'GH',
  'GI',
  'GR',
  'GL',
  'GD',
  'GP',
  'GU',
  'GT',
  'GG',
  'GN',
  'GW',
  'GY',
  'HT',
  'HM',
  'VA',
  'HN',
  'HK',
  'HU',
  'IS',
  'IN',
  'ID',
  'IR',
  'IQ',
  'IE',
  'IM',
  'IL',
  'IT',
  'JM',
  'JP',
  'JE',
  'JO',
  'KZ',
  'KE',
  'KI',
  'KP',
  'KR',
  'KW',
  'KG',
  'LA',
  'LV',
  'LB',
  'LS',
  'LR',
  'LY',
  'LI',
  'LT',
  'LU',
  'MO',
  'MK',
  'MG',
  'MW',
  'MY',
  'MV',
  'ML',
  'MT',
  'MH',
  'MQ',
  'MR',
  'MU',
  'YT',
  'MX',
  'FM',
  'MD',
  'MC',
  'MN',
  'ME',
  'MS',
  'MA',
  'MZ',
  'MM',
  'NA',
  'NR',
  'NP',
  'NL',
  'NC',
  'NZ',
  'NI',
  'NE',
  'NG',
  'NU',
  'NF',
  'MP',
  'NO',
  'OM',
  'PK',
  'PW',
  'PS',
  'PA',
  'PG',
  'PY',
  'PE',
  'PH',
  'PN',
  'PL',
  'PT',
  'PR',
  'QA',
  'RE',
  'RO',
  'RU',
  'RW',
  'BL',
  'SH',
  'KN',
  'LC',
  'MF',
  'PM',
  'VC',
  'WS',
  'SM',
  'ST',
  'SA',
  'SN',
  'RS',
  'SC',
  'SL',
  'SG',
  'SX',
  'SK',
  'SI',
  'SB',
  'SO',
  'ZA',
  'GS',
  'SS',
  'ES',
  'LK',
  'SD',
  'SR',
  'SJ',
  'SZ',
  'SE',
  'CH',
  'SY',
  'TW',
  'TJ',
  'TZ',
  'TH',
  'TL',
  'TG',
  'TK',
  'TO',
  'TT',
  'TN',
  'TR',
  'TM',
  'TC',
  'TV',
  'UG',
  'UA',
  'AE',
  'GB',
  'US',
  'UM',
  'UY',
  'UZ',
  'VU',
  'VE',
  'VN',
  'VG',
  'VI',
  'WF',
  'EH',
  'YE',
  'ZM',
  'ZW',
];
