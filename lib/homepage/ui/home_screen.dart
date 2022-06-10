import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),

        bottomNavigationBar: BottomNavigationBar(
          iconSize: 20,
          selectedLabelStyle: optionStyle,
          unselectedLabelStyle: optionStyle,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/explore_unselected.png"),
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(
                "assets/images/search_unselected.png",
              )),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/book_unselected.png"),
              ),
              label: 'My Learning',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/more_unselected.png"),
              ),
              label: 'More',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF262261),
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _getStoryList() =>
      ListView.builder(itemCount: _list.length, itemBuilder: buildBody);

  Widget buildBody(BuildContext ctxt, int index) {
    return Text(_list[index]);
  }

  final List<String> _list = ["1", "2", "3", "4", "5"];

  Widget _getExploreScreen() => Container();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 12, fontFamily: "Comfortaa-Bold.ttf");
  static final List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Explore',
      style: optionStyle,
    ),
    Text(
      'Index 1: Search',
      style: optionStyle,
    ),
    Text(
      'Index 2: My Learning',
      style: optionStyle,
    ),
    Text(
      'Index 3: More',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      /*Navigator.of(context).push(MaterialPageRoute<Null>(builder: (context) {
        return _widgetOptions[_selectedIndex];
      }));*/
    });
  }
}