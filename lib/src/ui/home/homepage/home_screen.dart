import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../explore/explore_screen.dart';

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
        /* bottomNavigationBar: PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.white,
            navBarHeight: 65,
            // Default is Colors.white.
            handleAndroidBackButtonPress: true,
            // Default is true.
            resizeToAvoidBottomInset: true,
            // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: true,
            // Default is true.
            hideNavigationBarWhenKeyboardShows: true,
            // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(0.0),
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle
                .style3, // Choose the nav bar style with this property.
          )*/

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

  /*List<Widget> _buildScreens() {
    return _widgetOptions;
  }

  String title1 = Text(
    "Explore",
    style: TextStyle(fontSize: 12.0, fontFamily: "Comfortaa-bold.ttf"),
  ).data;

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage("assets/images/explore_unselected.png"),
        ),
        title: title1,
        activeColorPrimary: Color(0xFF262261),
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage(
          "assets/images/search_unselected.png",
        )),
        title: "Search",
        activeColorPrimary: Color(0xFF262261),
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage("assets/images/book_unselected.png"),
        ),
        title: 'My Learning',
        activeColorPrimary: Color(0xFF262261),
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage("assets/images/more_unselected.png"),
        ),
        title: 'More',
        activeColorPrimary: Color(0xFF262261),
      ),
    ];
  }*/

  Widget _getStoryList() =>
      ListView.builder(itemCount: _list.length, itemBuilder: buildBody);

  // A Separate Function called from itemBuilder
  Widget buildBody(BuildContext ctxt, int index) {
    return Text(_list[index]);
  }

  final List<String> _list = ["1", "2", "3", "4", "5"];

  Widget _getExploreScreen() => Container();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 12, fontFamily: "Comfortaa-Bold.ttf");
  static final List<Widget> _widgetOptions = <Widget>[
    ExploreScreen(),
    Text(
      'Index 1: inal Business',
      style: optionStyle,
    ),
    ExploreScreen(),
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

  Widget _showborder() => Container(
      // Negative padding
      transform: Matrix4.translationValues(0.0, -2.6, 0.0),
      // Add top border
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFF262261),
            width: 0.6,
          ),
        ),
      ));
}
