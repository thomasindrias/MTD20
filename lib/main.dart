import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mtd20/pages/page_1.dart';
import 'package:mtd20/pages/page_2.dart';
import 'package:mtd20/pages/page_3.dart';
import 'package:mtd20/pages/page_4.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mtd20/pages/page_intro.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      title: "MTD20",
      home: IntroScreen(),
      routes: <String, WidgetBuilder>{
        // Set routes for using the Navigator.
        '/intro': (BuildContext context) => new IntroScreen(),
        '/home': (BuildContext context) => new HomePage()
      },
      debugShowCheckedModeBanner: false,
    ));
  });
}

class Router extends StatefulWidget {
  Router({Key key}) : super(key: key);

  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    print(_seen);

    if (_seen) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacementNamed('/intro');
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 200), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex;
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    initializeDateFormatting();
    permissionHandler();
  }

  void permissionHandler() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.contacts]);
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            changePage(index);
          },
          children: <Widget>[
            FirstPage(),
            SecondPage(),
            ThirdPage(),
            FourthPage()
          ],
        ),
      ),
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        opacity: .2,
        currentIndex: currentIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(
                16)), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.deepOrange.shade200,
              icon: Icon(
                FontAwesomeIcons.newspaper,
                color: Colors.black,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.solidNewspaper,
                color: Colors.red,
              ),
              title: Text("Hem")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepOrange.shade200,
              icon: Icon(
                FontAwesomeIcons.calendar,
                color: Colors.black,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.solidCalendar,
                color: Colors.red,
              ),
              title: Text("Schema")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepOrange.shade200,
              icon: Icon(
                FontAwesomeIcons.building,
                color: Colors.black,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.solidBuilding,
                color: Colors.red,
              ),
              title: Text("Företag")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepOrange.shade200,
              icon: Icon(
                FontAwesomeIcons.infoCircle,
                color: Colors.black,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.infoCircle,
                color: Colors.red,
              ),
              title: Text("Om"))
        ],
      ),
    );
  }
}
