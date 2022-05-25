

import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
