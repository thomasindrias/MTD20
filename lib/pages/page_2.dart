import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mtd20/models/event.dart';
import 'package:mtd20/pages/event_detail_screen.dart';
import 'package:mtd20/styleguide.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final Color bgColor = Color(0xffF3F3F3);
  final Color primaryColor = Color(0xffE70F0B);
  DateFormat dateFormat;

  var url = "https://thomasindrias.github.io/mtd/data/events.json";

  Events events;
  var firstIncomingEvent;
  mtdEvent now;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await fetchData();
    dateFormat = new DateFormat("d MMM HH:mm", "sv_SE");
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await fetchData();
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void _currentEvents() {
    for (var i = 0; i < events.events.length; i++) {
      //Check if event is happening now
      if (DateTime.now().isAfter(DateTime.parse(events.events[i].start)
              .add(new Duration(hours: 1))) &&
          DateTime.now().isBefore(DateTime.parse(events.events[i].end)
              .add(new Duration(hours: 1)))) {
        now = events.events[i];
      }
      //Find first incoming event
      if (DateTime.now().isBefore(
          DateTime.parse(events.events[i].start).add(new Duration(hours: 1)))) {
        firstIncomingEvent = i;
        break;
      }
    }
  }

  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    dateFormat = new DateFormat("EEEE, HH:mm", "sv_SE");
    fetchData();
  }

  //Fetch json data from http
  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    events = Events.fromJson(decodedJson);

    _currentEvents();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 8.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Schema", style: AppTheme.display1),
                    TextSpan(text: "\n"),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 10.0, // has the effect of softening the shadow
                  spreadRadius: 15.0, // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal, move right 10
                    0.0, // vertical, move down 10
                  ),
                )
              ],
            )),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: events == null
                  ? Center(child: CircularProgressIndicator())
                  : SmartRefresher(
                      enablePullDown: true,
                      header: WaterDropHeader(),
                      footer: CustomFooter(
                        builder: (BuildContext context, LoadStatus mode) {
                          Widget body;
                          if (mode == LoadStatus.loading) {
                            body = CupertinoActivityIndicator();
                          } else if (mode == LoadStatus.failed) {
                            body = Text("Försök igen");
                          }
                          return Container(
                            height: 55.0,
                            child: Center(child: body),
                          );
                        },
                      ),
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: _buildArticles(events.events),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticles(events) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        now == null
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("Just nu", style: AppTheme.display3),
                  ),
                  const SizedBox(height: 16.0),
                  InkWell(
                    splashColor: Colors.orange.withOpacity(0.8),
                    highlightColor: Colors.white60,
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeftWithFade,
                              child: EventDetailScreen(event: now),
                              curve: Curves.elasticInOut));
                    },
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 200.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    image: DecorationImage(
                                      image:
                                          CachedNetworkImageProvider(now.image),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  now.title,
                                  style: AppTheme.articleTitleStyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Slutar kl. ${new DateFormat("HH:mm").format(DateTime.parse(now.end).add(new Duration(hours: 1)))}',
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Text(
                                      now.place,
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Divider(),
                ],
              ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text("Kommande evenemang", style: AppTheme.display3),
        ),
        SizedBox(
          height: 10,
        ),
        for (var i = firstIncomingEvent; i < events.length; i++)
          _buildCard(events[i])
      ],
    );
  }

  Widget _buildCard(mtdEvent event) {
    return InkWell(
      splashColor: Colors.orange.withOpacity(0.8),
      highlightColor: Colors.white60,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: EventDetailScreen(event: event),
                curve: Curves.elasticInOut));
      },
      child: Padding(
        padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 4.0, right: 4.0),
        child: ListTile(
          title: Text(
            event.title,
            style: AppTheme.articleTitleStyle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              '${new DateFormat("EEEE d MMM 'kl.' HH:mm", "sv_SE").format(DateTime.parse(event.start).add(new Duration(hours: 1)))}',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          trailing: Container(
            width: 80.0,
            height: 90.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(event.image),
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
