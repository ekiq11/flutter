import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pdp_wisatakuliner/screens/admin/main_screen_admin.dart';
import 'package:pdp_wisatakuliner/screens/join.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screen.dart';

class Walkthrough extends StatefulWidget {
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  String level;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      level = preferences.getString("level");
      if (level == '1') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MainScreen();
            },
          ),
        );
      } else if (level == '2') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MainScreenAdmin();
            },
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  List pageInfos = [
    {
      "title": "Makanan Tradisional",
      "body": "Cari makanan tradisional khas lombok yang anda inginkan.",
      "img": "assets/on1.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      for (int i = 0; i < pageInfos.length; i++) _buildPageModel(pageInfos[i])
    ];

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: IntroductionScreen(
            pages: pages,
            onDone: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return JoinApp();
                  },
                ),
              );
            },
            onSkip: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return JoinApp();
                  },
                ),
              );
            },
            showSkipButton: true,
            skip: Text("Skip"),
            next: Text(
              "Next",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
              ),
            ),
            done: Text(
              "Done",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildPageModel(Map item) {
    return PageViewModel(
      title: item['title'],
      body: item['body'],
      image: Image.asset(
        item['img'],
        height: 185.0,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).accentColor,
        ),
        bodyTextStyle: TextStyle(fontSize: 15.0),
//        dotsDecorator: DotsDecorator(
//          activeColor: Theme.of(context).accentColor,
//          activeSize: Size.fromRadius(8),
//        ),
        pageColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
