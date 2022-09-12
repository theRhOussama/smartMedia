import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smartmedia/utils/colors.dart';

class Aricle_subScreen extends StatefulWidget {
  const Aricle_subScreen({Key? key}) : super(key: key);

  @override
  State<Aricle_subScreen> createState() => _Aricle_subScreenState();
}

class _Aricle_subScreenState extends State<Aricle_subScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Column(
    
   children: [
     Expanded(
      flex: 2,
    
      child: Container(
        height: 100,
        width: double.infinity,
        child: ElevatedButton.icon(
        
          onPressed: (){

            Navigator.pushNamed(context, '/journalist/addArticle');
          }, 
        style: ElevatedButton.styleFrom(primary: white,onPrimary: Colors.black),
     icon: const Icon(Icons.video_camera_front_outlined,color: primaryColor,  ), label: const Text('نشر  صوره / فيديو',style:TextStyle(color:darkColor,fontSize: 18,fontStyle: FontStyle.italic),)),
      ),
      
     ),
       Expanded
       (
        flex: 2,
        child: Container(
          width: double.infinity,
          height: 100,
          child: ElevatedButton.icon(onPressed: (){}, 
       style: ElevatedButton.styleFrom(primary: Colors.black),
       icon: const Icon(Icons.my_library_books_outlined,color: primaryColor,), label: const Text('نشر مقال',style: TextStyle(color: white,fontStyle: FontStyle.italic,fontSize: 15),)),
        ),
     
       
     ),
     
     


   ],  
)
    );
    
  }
}