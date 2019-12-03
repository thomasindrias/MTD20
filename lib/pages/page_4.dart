import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mtd20/styleguide.dart';
import 'package:mtd20/models/character.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mtd20/widgets/character_widget.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class FourthPage extends StatefulWidget {
  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  //var url =
  //"https://raw.githubusercontent.com/aneromz/Test1/master/om/kontakt.json";

  //Character character;

  PageController _pageController;

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
  final String aboutTitle = "Medieteknikdagarna 2020";
  final String about =
      "Medieteknikdagarna är ett ideellt arrangemang drivet av och för studenter. 2020 går dagarna av stapeln för tjugonde gången. Syftet är att knyta kontakter mellan studenter, medietekniker ute i arbetslivet och företagen inom branschen.";
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        viewportFraction: 0.87, initialPage: -5, keepPage: false);

    //scrollAnimation();
    //fetchData();
  }

  Future scrollAnimation() async {
    try {
      await Future.delayed(const Duration(seconds: 1), () {
        _pageController.animateToPage(0,
            curve: Curves.easeInOut, duration: Duration(seconds: 3));
      });
    } catch (e) {}
  }

  /*
  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);

    //character = Character.fromJson(decodedJson);

    setState(() {});
  }
*/

  openMapsSheet(context) async {
    try {
      final title = "Täppan";
      final description = "Campus Norrköping";
      final coords = Coords(58.590190, 16.176473);
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                          description: description,
                        ),
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 64,
          width: 64,
          child: FloatingActionButton(
            onPressed: () {
              openMapsSheet(context);
            },
            child: Icon(
              FontAwesomeIcons.mapMarkerAlt,
              size: 30,
            ),
            backgroundColor: Colors.orange,
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 8.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Om", style: AppTheme.display1),
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
              child: characters == null
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
                      child: ListView(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 350,
                                child: PageView(
                                  //physics: ClampingScrollPhysics(),
                                  controller: _pageController,
                                  children: [
                                    for (var i = 0; i < characters.length; i++)
                                      CharacterWidget(
                                          character: characters[i],
                                          pageController: _pageController,
                                          currentPage: i)
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                height: 300,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        aboutTitle,
                                        style: AppTheme.displayBold,
                                      ),
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        about,
                                        style: AppTheme.articleDescriptionStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
