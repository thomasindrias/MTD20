import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:mtd20/models/character.dart';
import 'package:mtd20/services/contact_service.dart';
import 'package:mtd20/styleguide.dart';
import 'package:flutter/material.dart';
import 'package:pos_pinch_zoom_image/pos_pinch_zoom_image.dart';

class CharacterDetailScreen extends StatefulWidget {
  // final double _expandedBottomSheetBottomPosition = 0;
  final double _collapsedBottomSheetBottomPosition = -250;
  final double _completeCollapsedBottomSheetBottomPosition = -330;
  final Character character;

  const CharacterDetailScreen({Key key, this.character}) : super(key: key);

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen>
    with AfterLayoutMixin<CharacterDetailScreen> {
  double _bottomSheetBottomPosition = -330;
  bool isCollapsed = false;

  GetIt locator = GetIt();

  void setupLocator() {
    locator.registerSingleton(CallsAndMessagesService());
  }

  @override
  void initState() {
    super.initState();
    setupLocator();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
            Hero(
              tag: "background-${widget.character.name}",
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.character.colors,
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16),
                    child: IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.close),
                      color: Colors.white.withOpacity(0.9),
                      onPressed: () {
                        setState(() {
                          _bottomSheetBottomPosition = widget
                              ._completeCollapsedBottomSheetBottomPosition;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Hero(
                        tag: "image-${widget.character.name}",
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: PinchZoomImage(
                              image: CachedNetworkImage(
                                placeholder: (context, url) => SpinKitPulse(
                                  color: Colors.white,
                                  size: 100.0,
                                ),
                                imageUrl: widget.character.imagePath,
                                height: screenHeight * 0.45,
                              ),
                              zoomedBackgroundColor:
                                  Color.fromRGBO(240, 240, 240, 1.0),
                              hideStatusBarWhileZooming: true,
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 8),
                    child: Hero(
                        tag: "name-${widget.character.name}",
                        child: Material(
                            color: Colors.transparent,
                            child: Container(
                                child: Text(widget.character.name,
                                    style: AppTheme.heading)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 8, 32),
                    child:
                        Text(widget.character.role, style: AppTheme.subHeading),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Ink(
                            decoration: ShapeDecoration(
                              color: Colors.deepOrange.shade200,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.phone),
                              iconSize: 46,
                              color: Colors.white,
                              onPressed: () =>
                                  _service.call(widget.character.number),
                            ),
                          ),
                          Ink(
                            decoration: ShapeDecoration(
                              color: Colors.deepOrange.shade200,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.sms),
                              iconSize: 46,
                              color: Colors.white,
                              onPressed: () =>
                                  _service.sendSms(widget.character.number),
                            ),
                          ),
                          Ink(
                            decoration: ShapeDecoration(
                              color: Colors.deepOrange.shade200,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.email),
                              iconSize: 46,
                              color: Colors.white,
                              onPressed: () =>
                                  _service.sendEmail(widget.character.email),
                            ),
                          )
                        ],
                      ),
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
