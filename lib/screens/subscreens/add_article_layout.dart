
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
});

            },

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

    final  Model.User? user = Provider.of<UserProvider>(context).getUser;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
             
              child: CircleAvatar(
                backgroundImage: NetworkImage((user?.photoUrl).toString()),
              ),
            ),SizedBox(width: MediaQuery.of(context).size.width*0.4,
            child: const TextField(
              style: TextStyle(color:Colors.red),
              
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
          SizedBox(height: 45,width: 45,child: AspectRatio(aspectRatio: 487/451,
          child: Container(decoration:  const BoxDecoration(
            image: DecorationImage(
              
               image: 
           
          
           NetworkImage("https://media.istockphoto.com/photos/white-texture-background-picture-id926993450?k=20&m=926993450&s=612x612&w=0&h=Er7TD07JWK0HEEaGEjgDCpyoUzpXa_95MhRlmvpKEpU="),
            fit: BoxFit.fill,
            alignment: FractionalOffset.topCenter)
            )
            )
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
        ],
      ),
       
    )
    ;
    
  }
}