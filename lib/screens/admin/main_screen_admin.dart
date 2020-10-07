import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdp_wisatakuliner/screens/admin/home_admin.dart';
import 'package:pdp_wisatakuliner/screens/admin/list_menu.dart';
import 'package:pdp_wisatakuliner/screens/admin/tambah_data.dart';
import 'package:pdp_wisatakuliner/screens/admin/maps.dart';
import 'package:pdp_wisatakuliner/screens/notifications.dart';
import 'package:pdp_wisatakuliner/screens/profile.dart';
import 'package:pdp_wisatakuliner/util/const.dart';
import 'package:pdp_wisatakuliner/widgets/badge.dart';

class MainScreenAdmin extends StatefulWidget {
  @override
  _MainScreenAdminState createState() => _MainScreenAdminState();
}

class _MainScreenAdminState extends State<MainScreenAdmin> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            Constants.appName,
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: IconBadge(
                icon: Icons.notifications,
                size: 22.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Notifications();
                    },
                  ),
                );
              },
              tooltip: "Notifications",
            ),
          ],
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            HomeAdmin(),
            ListMenu(),
            TambahData(),
            MapsNew(),
            Profile(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: 7),
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 24.0,
                ),
                color: _page == 0
                    ? Theme.of(context).accentColor
                    : Theme.of(context).textTheme.caption.color,
                onPressed: () => _pageController.jumpToPage(0),
              ),
              IconButton(
                icon: Icon(
                  Icons.list,
                  size: 24.0,
                ),
                color: _page == 1
                    ? Theme.of(context).accentColor
                    : Theme.of(context).textTheme.caption.color,
                onPressed: () => _pageController.jumpToPage(1),
              ),
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 24.0,
                  color: Theme.of(context).primaryColor,
                ),
                color: _page == 2
                    ? Theme.of(context).accentColor
                    : Theme.of(context).textTheme.caption.color,
                onPressed: () => _pageController.jumpToPage(2),
              ),
              IconButton(
                icon: Icon(
                  Icons.map,
                  size: 24.0,
                ),
                color: _page == 3
                    ? Theme.of(context).accentColor
                    : Theme.of(context).textTheme.caption.color,
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return MapsNew();
                })),
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 24.0,
                ),
                color: _page == 4
                    ? Theme.of(context).accentColor
                    : Theme.of(context).textTheme.caption.color,
                onPressed: () => _pageController.jumpToPage(4),
              ),
              SizedBox(width: 7),
            ],
          ),
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          child: Icon(
            Icons.add,
          ),
          onPressed: () => _pageController.jumpToPage(2),
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
