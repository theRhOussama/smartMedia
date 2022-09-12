import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartmedia/providers/user_provider.dart';
import 'package:smartmedia/utils/dimentions.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget WebScreenLayout;
  final Widget mobileScreenLayout;

  // ignore: non_constant_identifier_names
  const ResponsiveLayout({super.key, required this.WebScreenLayout, required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }
addData()async{
  UserProvider _userProvider = Provider.of(context,listen: false);
  await _userProvider.refresh();
  
}
  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(builder:(context,constraints){
   if(constraints.maxWidth> webScreenSize)
   {
    //web screen 
    return widget.WebScreenLayout;
   }
   //mobile screen layout
   return widget.mobileScreenLayout;
    }
    );
  }
}