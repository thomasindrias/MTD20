import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:after_layout/after_layout.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mtd20/models/event.dart';
import 'package:mtd20/services/contact_service.dart';
import 'package:mtd20/styleguide.dart';
import 'package:flutter/material.dart';
import 'package:mtd20/models/network_image.dart';

class EventDetailScreen extends StatefulWidget {
  // final double _expandedBottomSheetBottomPosition = 0;
  final double _collapsedBottomSheetBottomPosition = -250;
  final double _completeCollapsedBottomSheetBottomPosition = -330;
  final mtdEvent event;

  const EventDetailScreen({Key key, this.event}) : super(key: key);

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen>
    with AfterLayoutMixin<EventDetailScreen> {
  double _bottomSheetBottomPosition = -330;
  bool isCollapsed = false;
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  DateFormat dateFormat;

  GetIt locator = GetIt();

  void setupLocator() {
    locator.registerSingleton(CallsAndMessagesService());
  }

  @override
  void initState() {
    super.initState();
    dateFormat = new DateFormat("d MMM", "sv_SE");
    setupLocator();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

    return Scaffold(
      key: scaffoldState,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 64,
          width: 64,
          child: FloatingActionButton(
            onPressed: () {
              Add2Calendar.addEvent2Cal(Event(
                title: '${widget.event.title} med ${widget.event.host}',
                description: widget.event.description,
                location: widget.event.place,
                startDate: DateTime.parse("2020-03-05T08:30:00+0100"),
                endDate: DateTime.parse("2020-03-05T08:30:00+0100")
                    .add(Duration(hours: 2)),
                allDay: false,
              )).then((success) {
                scaffoldState.currentState.showSnackBar(SnackBar(
                    backgroundColor: success ? Colors.green : Colors.red,
                    content: Text(
                      success ? 'Laddar..' : 'Försök igen',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    )));
              });
            },
            child: Icon(
              Icons.calendar_today,
              size: 30,
            ),
            backgroundColor: Colors.orange,
          ),
        ),
      ),
      body: Dismissible(
        direction: DismissDirection.down,
        key: Key('key'),
        onDismissed: (direction) {
          Navigator.pop(context);
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            //Hero(tag: "background-${widget.events.title}"),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 16),
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
                            widget.event.image,
                            width: screenWidth,
                            height: 300,
                            fit: BoxFit.cover,
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        Text(
                          '${dateFormat.format(DateTime.parse(widget.event.start))} ${widget.event.time}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          "Plats: " + widget.event.place,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                        ),
                        Text(
                          widget.event.title,
                          style: AppTheme.articleTitleStyle,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        widget.event.description != null
                            ? Text(
                                widget.event.description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 16,
                                    height: 1.3,
                                    fontFamily: 'Lato'),
                              )
                            : Text("")
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
