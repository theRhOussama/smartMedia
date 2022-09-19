import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartmedia/screens/subscreens/post_card.dart';
import 'package:smartmedia/utils/colors.dart';
class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: secondColor,
      centerTitle: true,
      title:Text("الصفحه الرئيسيه") ,
      actions: [IconButton(onPressed: (){}, icon: Icon(Icons.document_scanner,color: white,)),
      
      
      ],
      ),
    body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: ((context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot ) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
           child: CircularProgressIndicator(),
          );

        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: ((context, index) =>  PostCard(
              snap:snapshot.data!.docs[index]
          )
        ));
        
      }),
    ),
    );
  }
}