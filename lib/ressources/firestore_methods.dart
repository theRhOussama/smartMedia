
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartmedia/models/post.dart';
import 'package:smartmedia/ressources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods 
{
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;
  //upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profileImage
  ) async{
  String res = "waiting";
  
    try{
      res="waiting";
      String photoUrl=await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId= const Uuid().v1();
      Post post = Post(description:description,uid: uid ,username: username,
      postId:postId ,datePublished: DateTime.now().toString(),
      keysPost: [],profileImage:profileImage ,
      photoPostUrl: photoUrl,likes: []
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res= "success";
    }catch(err){
        res=err.toString();
    }
    return res;
  }
  Future<int> likePost(String postId,String uid,List likes) async{
    int result = 0;
  try{
     if(likes.contains(uid)){
   await   _firestore.collection('posts').doc(postId).update({
          'likes':FieldValue.arrayRemove([uid])
      });
      result= 0;
     }else{
       await  _firestore.collection('posts').doc(postId).update({
          'likes':FieldValue.arrayUnion([uid])
      });
      result=1;
     }
  
  }catch(e){
    print(e.toString());
  }
   return result;
}
}
