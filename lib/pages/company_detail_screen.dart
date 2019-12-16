import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mtd20/models/companies.dart';
import 'package:mtd20/styleguide.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pos_pinch_zoom_image/pos_pinch_zoom_image.dart';

class CharacterDetailScreen extends StatefulWidget {
  // final double _expandedBottomSheetBottomPosition = 0;
  final double _collapsedBottomSheetBottomPosition = -250;
  final double _completeCollapsedBottomSheetBottomPosition = -330;
  final Bron company;

  const CharacterDetailScreen({Key key, this.company}) : super(key: key);

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen>
    with AfterLayoutMixin<CharacterDetailScreen> {
  double _bottomSheetBottomPosition = -330;
  bool isCollapsed = false;

  _launchURL() async {
    String url = widget.company.website;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
              tag: "background-${widget.company.name}",
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.shade200,
                      Colors.deepOrange.shade400
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              //physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        tag: "image-${widget.company.name}",
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: PinchZoomImage(
                              image: CachedNetworkImage(
                                placeholder: (context, url) => SpinKitPulse(
                                  color: Colors.white,
                                  size: 100.0,
                                ),
                                imageUrl: widget.company.logo,
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
                        tag: "name-${widget.company.name}",
                        child: Material(
                            color: Colors.transparent,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(widget.company.name,
                                      style: AppTheme.heading),
                                ),
                                IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.externalLinkAlt,
                                    color: Colors.white70,
                                    size: 26,
                                  ),
                                  onPressed: _launchURL,
                                  splashColor: Colors.transparent,
                                ),
                              ],
                            ))),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 8, 10),
                      child: Wrap(
                        children: <Widget>[
                          for (var i = 0; i < widget.company.offer.length; i++)
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                                child: FilterChip(
                                  elevation: 2.0,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.8),
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  label: Text(
                                    widget.company.offer[i],
                                    style: TextStyle(
                                        fontSize: 16,
                                        height: 1.3,
                                        fontFamily: 'Lato'),
                                  ),
                                  onSelected: (b) {},
                                ))
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 8, 20),
                    child: Text(
                      widget.company.info,
                      style: AppTheme.subHeading,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

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
