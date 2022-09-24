import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smartmedia/screens/subscreens/journalist_article_screen.dart';
import 'package:smartmedia/screens/subscreens/journalist_home_screen.dart';
import 'package:smartmedia/utils/colors.dart';

class JournalistScreen extends StatefulWidget {
  const JournalistScreen({Key? key}) : super(key: key);

  @override
  State<JournalistScreen> createState() => _JournalistScreentate();
}

class _JournalistScreentate extends State<JournalistScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3, child: 
    Scaffold(appBar: AppBar(title: Text('رواق الصحفي'),backgroundColor: secondColor,centerTitle: true,
    bottom:const  TabBar(tabs: [
       Tab(text: 'مرحبا',icon: Icon(Icons.home_max),), 
      Tab(text: 'أنشر مقالك',icon: Icon(Icons.pause_presentation),),
      Tab(text: 'الرصيد الحالي',icon: Icon(Icons.monetization_on),),
    ]),
    
    ),
    body:  const  TabBarView(children:[
       JournalistHomeScreen(),
       Aricle_subScreen(),
        
            Center(child: Text('3'),),

    ],
    )
    )
    );
    
  }
}