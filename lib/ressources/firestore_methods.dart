import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartmedia/models/post.dart';
import 'package:smartmedia/ressources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //--------------------------------------upload post*-----------------------------
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profileImage) async {
    String res = "waiting";

    try {
      res = "waiting";
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now().toString(),
          keysPost: [],
          profileImage: profileImage,
          photoPostUrl: photoUrl,
          likes: []);
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  /*-----------------------------------------Like The post----------------------------- */
  Future<bool> likePost(String postId, String uid, List likes) async {
    bool check = false;

    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
        check = false;
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
        check = true;
      }
    } catch (e) {
      print(e.toString());
    }
    return check;
  }

  /**-------------------- Post Comment Method ---------------------------------------------- */
  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set({
          'profileImage': profilePic,
          'username': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        }
        );
     print("------------------it's working brooo");

      } else {
        print(
            "--------------------------------text is empty bro----------------");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
