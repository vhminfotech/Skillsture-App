import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Color(0xFF262261),
          alignment: Alignment.topCenter,
          /*padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),*/
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset("assets/images/splash_logo.png",
                    alignment: Alignment.topLeft, width: 130, height: 27),
              ),
              Expanded(
                child: Image.asset("assets/images/ic_visual.png",
                    alignment: Alignment.bottomRight,
                    width: double.infinity,
                    height: 170,
                    fit: BoxFit.cover),
              )
            ],
          )),
    );
  }
}
