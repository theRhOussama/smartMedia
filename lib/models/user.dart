 
 

import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final  String typeOfuser;
  final String username;
  final String uid;
  final String firstname;
  final String lastname;
  final String phoneNumber;
   final List followers;
  final List following; 
  final  String  photoUrl;
  final String email; 
 
const User(
  {
    required  this.typeOfuser, 
    required this.username,required this.uid,required this.firstname,required this.lastname, required this.phoneNumber,required this.followers,required this.following,
    required this.photoUrl, required this.email
  }
);
Map<String,dynamic> toJson()=>{
  "typeOfuser":typeOfuser,
  "username":username,
  "uid":uid,
  "firstname":firstname,"lastname":lastname,"phoneNumber":phoneNumber,"follower":followers,
  "following":following,"photoUrl":photoUrl,"email":email
};

 static User  reversDocumentTosnap(DocumentSnapshot snap){
  var snapshot = snap.data() as Map<String,dynamic>;
  return User(
    username: snapshot['username'],
    uid: snapshot['uid'],
    email: snapshot['email'],
    firstname: snapshot['firstname'],
    lastname: snapshot['lastname'],
    followers: snapshot['follower'],
    following: snapshot['following'],
    phoneNumber: snapshot['phoneNumber'],
    typeOfuser: snapshot['typeOfuser'],
    photoUrl: snapshot['photoUrl']
    
  );

 }

}