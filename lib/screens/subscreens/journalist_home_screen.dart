import 'package:flutter/material.dart';
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
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Stack(children: [
            Container(
              color: white,
              child: SizedBox(
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.9,
                      child: ClipPath(
                          clipper: WaveClipper(),
                          child: Container(
                            color: secondColor,
                            height: 160,
                          )),
                    ),
                    ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          color: secondColor,
                          height: 140,
                        )),
                  ],
                ),
              ),
            ),
          ]),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 200,
            color: white,
            child: Row(children: [
              Center(
                  child: SvgPicture.asset(
                'assets/remoteTeam.svg',
                height: 130,
                alignment: Alignment.center,
              )),
              TextButton.icon(
                icon: const Icon(Icons.cloud_upload,
                    color: secondColor,
                    size: 48,
                    textDirection: TextDirection.rtl),
                label: const Text(
                  'أنشر مقالك',
                  style: TextStyle(
                      color: secondColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
              ),
            ]),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 150,
            color: secondColor,
            child: Row(children: [
              Center(
                  child: SvgPicture.asset(
                'assets/statistics.svg',
                height: 130,
                alignment: Alignment.center,
              )),
              TextButton.icon(
                icon: const Icon(Icons.align_vertical_bottom_rounded,
                    color: Colors.orange,
                    size: 48,
                    textDirection: TextDirection.rtl),
                label: const Text(
                  'الرصيد الحالي',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
              ),
            ]),
          ),
        ),
      ],
    ));
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making a curve
    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second pint of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
