 
 import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
 
import 'package:smartmedia/screens/feed_screen.dart';
import 'package:smartmedia/utils/colors.dart';

import '../screens/journalistscreen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;
  void navigationTapped(page) {
    pageController.jumpToPage(page);
    print(
        '------------------------------------------$page -----------------------------------------------------------------');
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
      print(
          '${_page} is the current Page MotherFucker ----------------------------------');
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondColor,
          title: Center(
            child: SvgPicture.asset(
              "assets/1.svg",
              color: Colors.white,
              height: 80,
            ),
          ),
          centerTitle: true,
          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: const [
            FeedScreen(),
            JournalistScreen(),
            Text('222222222222222222222'),
            Text('33333333333333333'),
          ],
        ),
        // ignore: prefer_const_constructors
        bottomNavigationBar: GNav(
          rippleColor: Colors.black, // tab button ripple color when pressed
          hoverColor: Colors.blue, // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 15,
          tabActiveBorder:
              Border.all(color: Colors.white, width: 1), // tab button border
          tabBorder:
              Border.all(color: Colors.white, width: 1), // tab button border
          tabShadow: [
            BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 8)
          ], // tab button shadow
          curve: Curves.easeOutExpo, // tab animation curves
          duration: Duration(milliseconds: 400), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Colors.black, // unselected icon color
          activeColor: primaryColor, // selected icon and text color
          iconSize: 27, // tab button icon size
          tabBackgroundColor:
              Colors.blue.withOpacity(0.1), // selected tab background color
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 5), // navigation bar padding
          // ignore: prefer_const_literals_to_create_immutables
          tabs: [
            // ignore: prefer_const_constructors
            GButton(
              icon: Icons.home,
              text: 'الرئيسيه',
              iconColor: Colors.grey,
            ),

            const GButton(
              icon: Icons.mic_external_on_sharp,
              text: 'صحفي',
               iconColor: Colors.grey,
            ),
            const GButton(
              icon: Icons.search,
              text: 'بحت',
                iconColor: Colors.grey,
            ),
            const GButton(
              icon: Icons.person_pin_circle_sharp,
              text: 'حسابي',
               iconColor: Colors.grey,
            )
          ],
          onTabChange: (index) => navigationTapped(index),
        ));
  }
}
