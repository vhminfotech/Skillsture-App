import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  final List<String> _list = [
    "assets/images/ic_google.png",
    "assets/images/ic_facebook.png",
    "assets/images/ic_google.png",
    "assets/images/ic_facebook.png",
    "assets/images/ic_google.png"
        "assets/images/ic_google.png"
        "assets/images/ic_google.png"
        "assets/images/ic_google.png"
        "assets/images/ic_google.png"
        "assets/images/ic_google.png"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
      SizedBox(height: 100.0, child: _getStoryList()),
    ])))));
    /*Scaffold(body: _getStoryList())*/;
  }

  Widget _getStoryList() => ListView.builder(
        itemCount: _list.length,
        itemBuilder: buildBody,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      );

  // A Separate Function called from itemBuilder
  Widget buildBody(BuildContext ctxt, int index) {
    return CircleAvatar(
      radius: 35,
      backgroundColor: Colors.red, // Border radius
      child: ClipOval(
        child: Image.asset(
          Text(_list[index]).data,
          width: 50,
          height: 50,
        ),
      ),
    ) /*Text(_list[index])*/;
  }
}
