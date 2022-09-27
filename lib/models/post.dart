

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

class Post{
  final String username;
  final String uid;
  final List keysPost;
  final  String profileImage;
  final String postId;
  final String description;
  final String photoPostUrl;
  final String datePublished;
  final dynamic   likes; 
  const Post({
    required this.profileImage,
    required this.likes,//
    required this.postId,
    required this.datePublished,//
    required this.photoPostUrl,//
    required this.username,//
    required this.uid,//
    required this.keysPost,//
    required this.description,//
   });
  Map<String,dynamic>toJson()=>{
    "profileImage":profileImage,
    "postId":postId,
"username":username,
"likes":likes,
"datePublished":datePublished,
"uid":uid,
"keyPost":keysPost,
"description":description,
"photoPostUrl":photoPostUrl
  };

  static Post reversDocumentTosnap(DocumentSnapshot snap){
    var snapshot=snap.data() as Map<String,dynamic>;
    return Post(
      profileImage: snapshot['profileImage'],
      postId: snapshot['postId'],likes: snapshot['likes'],
      datePublished: snapshot['datePublished'],
      username: snapshot['username'], uid: snapshot['uid'], keysPost: snapshot['keyPost'], description: snapshot['description'], photoPostUrl: snapshot['photoPostUrl']);
  }
}