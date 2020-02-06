import 'package:after_layout/after_layout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mtd20/models/article.dart';
import 'package:mtd20/services/contact_service.dart';
import 'package:flutter/material.dart';
import 'package:mtd20/models/network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailScreen extends StatefulWidget {
  // final double _expandedBottomSheetBottomPosition = 0;
  final double _collapsedBottomSheetBottomPosition = -250;
  final double _completeCollapsedBottomSheetBottomPosition = -330;
  final ArticleElement article;

  const ArticleDetailScreen({Key key, this.article}) : super(key: key);

  @override
  _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen>
    with AfterLayoutMixin<ArticleDetailScreen> {
  double _bottomSheetBottomPosition = -330;
  bool isCollapsed = false;
  DateFormat dateFormat;

  GetIt locator = GetIt();

  void setupLocator() {
    locator.registerSingleton(CallsAndMessagesService());
  }

  _launchURL() async {
    String url = widget.article.website;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    dateFormat = new DateFormat("d MMM HH:mm", "sv_SE");
    setupLocator();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

    return Scaffold(
      body: Dismissible(
        direction: DismissDirection.down,
        key: Key('key'),
        onDismissed: (direction) {
          Navigator.pop(context);
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            //Hero(tag: "background-${widget.article.title}"),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 16),
                    child: IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.arrow_back),
                      color: Colors.black.withOpacity(0.9),
                      onPressed: () {
                        setState(() {
                          _bottomSheetBottomPosition = widget
                              ._completeCollapsedBottomSheetBottomPosition;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 300,
                        width: double.infinity,
                        child: PNetworkImage(
                          widget.article.imagePath,
                          width: screenWidth,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 16.0, right: 16.0, bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  dateFormat.format(
                                      DateTime.parse(widget.article.time)),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.article.title,
                              style: Theme.of(context).textTheme.title,
                            ),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.externalLinkAlt,
                                color: Colors.black87,
                                size: 26,
                              ),
                              onPressed: _launchURL,
                              splashColor: Colors.transparent,
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          widget.article.description,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16, height: 1.3, fontFamily: 'Lato'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
            /*
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
              bottom: _bottomSheetBottomPosition,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: _onTap,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        height: 80,
                        child: Text(
                          "Clips",
                          style: AppTheme.subHeading.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _clipsWidget(),
                    ),
                  ],
                ),
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
/*
  Widget _clipsWidget() {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              roundedContainer(Colors.redAccent),
              SizedBox(height: 20),
              roundedContainer(Colors.greenAccent),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              roundedContainer(Colors.orangeAccent),
              SizedBox(height: 20),
              roundedContainer(Colors.purple),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              roundedContainer(Colors.grey),
              SizedBox(height: 20),
              roundedContainer(Colors.blueGrey),
            ],
          ),
          SizedBox(width: 16),
          Column(
            children: <Widget>[
              roundedContainer(Colors.lightGreenAccent),
              SizedBox(height: 20),
              roundedContainer(Colors.pinkAccent),
            ],
          ),
        ],
      ),
    );
  }
  */

  Widget roundedContainer(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }

/*
  _onTap() {
    setState(() {
      _bottomSheetBottomPosition = isCollapsed
          ? widget._expandedBottomSheetBottomPosition
          : widget._collapsedBottomSheetBottomPosition;
      isCollapsed = !isCollapsed;
    });
  }
*/

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isCollapsed = true;
        _bottomSheetBottomPosition = widget._collapsedBottomSheetBottomPosition;
      });
    });
  }
}
