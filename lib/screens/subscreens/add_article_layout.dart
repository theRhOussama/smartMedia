
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartmedia/models/user.dart'as Model;
import 'package:smartmedia/providers/user_provider.dart';
import 'package:smartmedia/utils/colors.dart';
import 'package:smartmedia/utils/utils.dart';

class AddArticleLayout extends StatefulWidget {

  
  const AddArticleLayout({Key? key}) : super(key: key);


  @override
  State<AddArticleLayout> createState() => _AddArticleLayoutState();
}
 
class _AddArticleLayoutState extends State<AddArticleLayout> {
    Uint8List? _file;

  _selectImage(BuildContext context) async{
    return showDialog(context: context, builder: (context){
      print("(----------------------------------------)");
      

    return  SimpleDialog(
      contentPadding: EdgeInsets.all(5),
      title: Text("اضافه منشور",style: TextStyle(fontSize: 15,color: primaryColor), textDirection: TextDirection.rtl,)  ,
      children: [
        SimpleDialogOption(
            padding:const EdgeInsets.all(20),
            child: const Text('أخد صوره من الكاميرة',textDirection: TextDirection.rtl,),
            onPressed: () async {
               
             Uint8List file = await pickImage(ImageSource.camera);
          

setState(() {
  _file=file;

 
}); },

        ),
         SimpleDialogOption(
            padding:const EdgeInsets.all(20),
            child: const Text('اختيار صوره ',textDirection: TextDirection.rtl),
            onPressed: () async {
               
             Uint8List file = await pickImage(ImageSource.gallery);
setState(() {
  _file=file;
});

            },

        )
      ],
    );
    } );

  }
  @override
  Widget build(BuildContext context) {

        final Model.User? user = Provider.of<UserProvider>(context).getUser  ;

    print("----------------------------------------------------------");
    print(user);
     
      // final int nom= context.read<int>() ;

      // print(nom);
return  Scaffold(
      backgroundColor: secondColor,
      appBar: AppBar
      (
       title: Text('اضافه صوره/فيديو',style: TextStyle(color: white,fontSize: 18),), 
       centerTitle: true,
        backgroundColor: secondColor,leading: IconButton(icon: const Icon(Icons.arrow_back),
      color: white,
      onPressed: (){Navigator.pop(context);},
      
      ),),
      body: Column(
        children: [
             SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         
             SizedBox(
             
              child: CircleAvatar(
                 backgroundImage: NetworkImage((user!.photoUrl).toString()),
              ),
            ),SizedBox(width: MediaQuery.of(context).size.width*0.4,
            child: const TextField(
              style: TextStyle(color:white),
              
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(hintText: " ...تعليق عن المحتوى",hintStyle: TextStyle(color: white),
              hintTextDirection: TextDirection.rtl,
              
              labelStyle: TextStyle(color: white),
               hoverColor: white,
              border: InputBorder.none,

            ),
            maxLines: 8,
            )
          ),
     
           Column(
          
           children: [
             Center(
              child: IconButton(icon: const Icon(Icons.upload_rounded,color: Colors.blue,),
              onPressed: (() => _selectImage(context)),
              
              
              ),
             ),
           ],
           )      
          ],
          ),
          
           SizedBox(
            height: 300,
            width: double.infinity,
            
            child:  
           _file != null ? Image.memory(_file!,alignment: Alignment.center,width: 300,) :
           Image.network("https://img.freepik.com/free-photo/gray-abstract-wireframe-technology-background_53876-101941.jpg?w=2000")
         
          ),
        ],
      ),
       
    )
    ;
    
  }
}