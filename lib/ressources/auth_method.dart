import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartmedia/ressources/storage_method.dart';
import 'package:smartmedia/models/user.dart' as model ;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore= FirebaseFirestore.instance;
  Future<model.User>getUserDetails()async{
    User  currentUser = _auth.currentUser!;
    DocumentSnapshot snap= await _firestore.collection('users').doc(currentUser.uid).get();
    return   model.User.reversDocumentTosnap(snap);
   

  }

  //sign up user
  Future<String>    signUpUser(
{   
    required  String typeOfuser,
   required String email,
    required String password,
    required String username,
    required String firstname,
    required String lastname,
    required String phoneNumber,
   required Uint8List file
}
  )async{

    String res= "Some error occured";
    try{
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || firstname.isNotEmpty||lastname.isNotEmpty||
      typeOfuser.isNotEmpty ||
      phoneNumber.isNotEmpty || file != null)
      {
        //register the user
      UserCredential cred=   await  _auth.createUserWithEmailAndPassword(email: email, password: password);
      
      print(cred.user!.uid);
   String photoUrl= await StorageMethods().uploadImageToStorage('profilePics', file, false);
  //add User to userDatabase 
model.User user = model.User(email: email,firstname: firstname,phoneNumber: phoneNumber,
 followers: [],following: [],lastname: lastname,photoUrl: photoUrl,uid:cred.user!.uid,typeOfuser: typeOfuser,
 username: username
);
  
     await  _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

        //Another way
        res='success';
      }
    }on FirebaseAuthException catch(err)
    {
      if(err.code =='invalid-email'){
        print('Failed with error code: ${err.code}');
      }
    }
    
    catch(err){
      res= err.toString();
    }
    return res;
  }

  Future<String> login({required String email,required String password})
  async 
  {
    String res ='Some errore occured';
  
  try{

if(email.isNotEmpty && password.isNotEmpty){
await  _auth.signInWithEmailAndPassword(email: email, password: password);
res='success';
}else {
  res='please enter all the fields';
}
  }catch(err){
    res= err.toString();
  }
  return res;
      }
}