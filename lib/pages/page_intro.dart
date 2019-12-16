import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Välkommen!",
        styleTitle: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato'),
        description:
            "Kul att du är intresserad av Medieteknikdagarna 2020! Med denna app kan du hålla koll på kommande evenemanger och företag.",
        styleDescription: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 16.0,
            height: 1.3,
            fontFamily: 'Lato'),
        pathImage: "assets/images/logo.png",
      ),
    );
  }

  void onDonePress() {
    // Back to the first tab
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void onSkipPress() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffffcc5c),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Text("Redo",
        style: TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.white.withOpacity(0.8),
          letterSpacing: 1.2,
        ));
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Stack(fit: StackFit.expand, children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade200, Colors.deepOrange.shade400],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Container(
            margin: EdgeInsets.only(bottom: 40.0, top: 100.0),
            child: ListView(
              children: <Widget>[
                Container(
                  child: Text(
                    currentSlide.title,
                    style: currentSlide.styleTitle,
                    textAlign: TextAlign.center,
                  ),
                  margin: EdgeInsets.only(top: 40.0),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      currentSlide.description,
                      style: currentSlide.styleDescription,
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  margin: EdgeInsets.only(top: 20.0),
                ),
                SizedBox(height: 130),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset(
                    currentSlide.pathImage,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
        )
      ]));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      renderDoneBtn: this.renderDoneBtn(),

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Show or hide status bar
      //shouldHideStatusBar: true,

      isShowDotIndicator: false,
      onDonePress: this.onDonePress,
      onSkipPress: this.onSkipPress,
    );
  }
}
