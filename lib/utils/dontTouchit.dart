import 'package:flutter/material.dart';
import 'package:smartmedia/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(backgroundColor: secondColor,title:Text('ركن الصحفي'), centerTitle: true,
bottomOpacity: 0.0,
elevation: 0.0,),
      body: Stack(
        
        children:[ Container(
          child: SizedBox(
            child: Stack(children: [
              Opacity(opacity:0.9,child:
               ClipPath(
                clipper: WaveClipper(),
                child:Container(color:secondColor,
               
                   
               height: 100,
               )
               ),
               ),ClipPath(
                clipper: WaveClipper(),
                child:Container(color:secondColor,
                
               height: 80,
               )
               ),
            
            ] , 
            ),
          ),
        ),
      ]
      
      ),
    );
    
  }
}
class WaveClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
   
    debugPrint(size.width.toString());
    var path = new Path();
    path.lineTo(0, size.height);//start path with this if you are making a curve
    var firstStart= Offset(size.width/5,size.height);
    //fist point of quadratic bezier curve
    var firstEnd= Offset(size.width/2.25,size.height-50.0);
    //second pint of quadratic bezier curve
    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart=Offset(size.width-(size.width/3.24),size.height-105);
    var secondEnd=Offset(size.width, size.height-10);
    path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx ,secondEnd.dy);
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