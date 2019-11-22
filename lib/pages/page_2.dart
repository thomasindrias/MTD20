import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtd20/models/event.dart';
import 'package:mtd20/pages/event_detail_screen.dart';
import 'package:mtd20/styleguide.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final Color bgColor = Color(0xffF3F3F3);
  final Color primaryColor = Color(0xffE70F0B);

  var url = "https://thomasindrias.github.io/mtd/data/events.json";

  Events events;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    events = Events.fromJson(decodedJson);

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
        const SizedBox(height: 16.0),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EventDetailScreen(event: events[0])));
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
                            image: CachedNetworkImageProvider(events[0].image),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        events[0].title,
                        style: AppTheme.articleTitleStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            events[0].start,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            events[0].host,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
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
        for (var i = 1; i < events.length; i++) _buildCard(events[i])
      ],
    );
  }

  Widget _buildCard(Event event) {
    return Padding(
        padding:
            EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EventDetailScreen(event: event)));
          },
          child: ListTile(
            title: Text(
              event.title,
              style: AppTheme.articleTitleStyle,
            ),
            subtitle: Text(event.start),
            trailing: Container(
              width: 80.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(event.image),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ));
  }
}
