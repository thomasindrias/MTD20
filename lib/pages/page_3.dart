import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtd20/styleguide.dart';
import 'package:mtd20/widgets/character_widget.dart';
import 'package:mtd20/pages/character_detail_screen.dart';
import 'package:mtd20/models/business.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  var url = "https://aneromz.github.io/utstallare.json";

  Business business;

  static const _kFontFam = 'Icon';
  static const IconData gem_regular =
      const IconData(0xe800, fontFamily: _kFontFam);

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
  @override
  void initState() {
    super.initState();
    fetchData();
    _pageController = PageController(
        viewportFraction: 1.0, initialPage: currentPage, keepPage: false);
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);

    business = Business.fromJson(decodedJson);

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
                    TextSpan(text: "Företag", style: AppTheme.display1),
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
              child: business == null
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
                      child: ListView(shrinkWrap: true, children: <Widget>[
                        SizedBox(height: 20),
                        Container(
                          height: 400,
                          child: PageView(
                            physics: ClampingScrollPhysics(),
                            controller: _pageController,
                            children: [
                              for (var i = 0; i < 2; i++)
                                CharacterWidget(
                                    character: business.samarbetspartners[i],
                                    pageController: _pageController,
                                    currentPage: i)
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child:
                              Text("Silverpartners", style: AppTheme.display3),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          height: 200,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            primary: false,
                            children: business.both
                                .map((foretag) => Container(
                                    width: 180, child: _buildCard(foretag)))
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child:
                              Text("Bronspartners", style: AppTheme.display3),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          height: 200,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            primary: false,
                            children: business.onsdag
                                .map((foretag) => Container(
                                    width: 180, child: _buildCard(foretag)))
                                .toList(),
                          ),
                        )
                      ])),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Both business) {
    return Padding(
        padding:
            EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      CharacterDetailScreen(character: business)));
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2.0,
                          blurRadius: 3.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                        tag: business.image,
                        child: Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(business.image),
                                    fit: BoxFit.contain)))),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Center(
                    child: Text(
                      business.name,
                      style:
                          TextStyle(color: Color(0xFF575E67), fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  )
                ]))));
  }
}
