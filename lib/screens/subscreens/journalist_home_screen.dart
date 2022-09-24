import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartmedia/utils/colors.dart';

class JournalistHomeScreen extends StatefulWidget {
  const JournalistHomeScreen({Key? key}) : super(key: key);

  @override
  State<JournalistHomeScreen> createState() => _JournalistHomeScreenState();
}

class _JournalistHomeScreenState extends State<JournalistHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              height: 300,
              width: double.infinity,
              color: darkColor,
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Image.asset('assets/social.png',
                                  height: 250)),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.only(right: 5),
                          alignment: Alignment.center,
                          child: const Text(
                            "كصحفي نشر الصور او مقاطع فيديو سيسمح لك بصناعه محتوى يتير رغبه القارء في التفاعل و كسب  متابعين",
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: white,
                                decorationStyle: TextDecorationStyle.double),
                          )))
                ],
              )),
          Container(
            width: double.infinity,
            color: darkColor,
            child: Center(
                child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/journalist/addArticle');
              },
              icon: const Icon(Icons.camera_indoor_outlined),
              label: Text("نشر صوره"),
            )),
          ),
          Container(
              color: darkColor,
              child: Image.asset(
                "assets/wohow.jpg",
                width: double.infinity,
                height: 200,
              )),
          Container(
              height: 300,
              width: double.infinity,
              color: darkColor,
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 3,
                              child: SvgPicture.asset('assets/test1.svg',
                                  height: 150)),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.only(right: 5),
                          alignment: Alignment.center,
                          child: const Text(
                            'كتابه مقال هي خاصيه ستسمح لك كصحفي أن تعالج موضوع   بتفاصيله ، تعطيكم هته الخاصيه مجموعه من الأدوات  ستسمح لكم  بالتوصل لاكبر عدد من القراء',
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: white,
                                decorationStyle: TextDecorationStyle.double),
                          )))
                ],
              )),
          Container(
            width: double.infinity,
            color: darkColor,
            child: Center(
                child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.dock_rounded,
                color: white,
              ),
              label: Text("كتابه مقال"),
            )),
          ),
          Container(
              height: 300,
              width: double.infinity,
              color: white,
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 3,
                              child:
                                  Image.asset('assets/payme.jpg', height: 250)),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                          color: white,
                          padding: EdgeInsets.only(right: 25),
                          alignment: Alignment.center,
                          child: Column(children: [
                            const SizedBox(
                              height: 100,
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(5),
                                  primary: Colors.blue[600]),
                              onPressed: () {},
                              icon: Icon(
                                Icons.ads_click,
                                color: white,
                              ),
                              label: Text("انقر هنا"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.orange[800]),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.info,
                                  color: white,
                                ),
                                label: Text(
                                  "تفاصيل أكتر",
                                  style: TextStyle(fontSize: 12),
                                )),
                            SizedBox(
                              height: 80,
                            )
                          ])))
                ],
              )),
        ],
      ),
    );
  }
}
