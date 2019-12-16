import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtd20/models/companies.dart';
import 'package:mtd20/styleguide.dart';
import 'package:mtd20/widgets/company_widget.dart';
import 'package:mtd20/pages/company_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'dart:convert';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  var url = "https://thomasindrias.github.io/mtd/data/companies.json";

  Companies companies;

  static const _kFontFam = 'Icon';
  static const IconData gem_regular =
      const IconData(0xe800, fontFamily: _kFontFam);

  PageController _pageController;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await fetchData();
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

  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    fetchData();
    _pageController = PageController(
      viewportFraction: 0.87,
      initialPage: -5,
      keepPage: false,
    );
    scrollAnimation();
  }

  Future scrollAnimation() async {
    try {
      await Future.delayed(const Duration(milliseconds: 0), () {
        _pageController.animateToPage(0,
            curve: Curves.easeInOut, duration: Duration(seconds: 1));
      });
    } catch (e) {}
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);

    companies = Companies.fromJson(decodedJson);

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
              child: companies == null
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
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text("Guldpartners", style: AppTheme.display3),
                        ),
                        Container(
                          height: 400,
                          child: PageView(
                            //physics: ClampingScrollPhysics(),
                            controller: _pageController,
                            children: [
                              for (var i = 0; i < companies.gold.length; i++)
                                CharacterWidget(
                                    company: companies.gold[i],
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
                            children: companies.silver
                                .map((foretag) => Container(
                                    width: 180, child: _buildCard(foretag)))
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 30),
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
                            children: companies.brons
                                .map((foretag) => Container(
                                    width: 180, child: _buildCard(foretag)))
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text("Andra", style: AppTheme.display3),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          height: 200,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            primary: false,
                            children: companies.other
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

  Widget _buildCard(Bron company) {
    return Padding(
        padding:
            EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.scale,
                      alignment: Alignment.bottomCenter,
                      child: CharacterDetailScreen(company: company)));
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
                        tag: company.logo,
                        child: Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      company.logo,
                                    ),
                                    fit: BoxFit.contain)))),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        company.name,
                        style:
                            TextStyle(color: Color(0xFF575E67), fontSize: 20.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  )
                ]))));
  }
}
