import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mtd20/pages/page_1.dart';
import 'package:mtd20/pages/page_2.dart';
import 'package:mtd20/pages/page_3.dart';
import 'package:mtd20/pages/page_4.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      title: "MTD20",
      home: HomePage(title: 'MTD20'),
      debugShowCheckedModeBanner: false,
    ));
  });
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
                FontAwesomeIcons.newspaper,
                color: Colors.red,
              ),
              title: Text("Hem")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepOrange.shade200,
              icon: Icon(
                Icons.calendar_today,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.calendar_today,
                color: Colors.red,
              ),
              title: Text("Schema")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepOrange.shade200,
              icon: Icon(
                Icons.business,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.business,
                color: Colors.red,
              ),
              title: Text("Företag")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepOrange.shade200,
              icon: Icon(
                Icons.info,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.info,
                color: Colors.red,
              ),
              title: Text("Kontakt"))
        ],
      ),
    );
  }
}
