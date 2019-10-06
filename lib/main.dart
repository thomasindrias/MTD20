import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:mtd20/pages/page_1.dart';
import 'package:mtd20/pages/page_2.dart';
import 'package:mtd20/pages/page_3.dart';
import 'package:mtd20/pages/page_4.dart';

void main() => runApp(MaterialApp(
      title: "MTD20",
      home: HomePage(title: 'MTD20'),
      debugShowCheckedModeBanner: false,
    ));

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
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xffec6610),
      ),
      body: PageView(
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
              backgroundColor: Color(0xffec6610),
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.red,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Color(0xffec6610),
              icon: Icon(
                Icons.access_time,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.access_time,
                color: Colors.red,
              ),
              title: Text("Logs")),
          BubbleBottomBarItem(
              backgroundColor: Color(0xffec6610),
              icon: Icon(
                Icons.folder_open,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.folder_open,
                color: Colors.red,
              ),
              title: Text("Folders")),
          BubbleBottomBarItem(
              backgroundColor: Color(0xffec6610),
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.menu,
                color: Colors.red,
              ),
              title: Text("Menu"))
        ],
      ),
    );
  }
}
