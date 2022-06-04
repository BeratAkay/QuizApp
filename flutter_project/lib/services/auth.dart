import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_application/models/user.dart';



class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Kullanici? _userFromFirebaseUser(user){
    return user !=null ? Kullanici(uid: user.uid) : null;
  }
  Future signInEmailAndPass(String email, String password) async{

    try{
      var authResult = await _auth.signInWithEmailAndPassword
        (email: email, password: password);
       var firebaseUser = authResult.user;
       return _userFromFirebaseUser(firebaseUser);
  }catch(e){
      print(e.toString());
    }
    }

    Future signUpWithEmailAndPassword(String email,String password) async{

      try{
        var authResult = await _auth.createUserWithEmailAndPassword
          (email: email, password: password);
            var firebaseUser=authResult.user;
            return _userFromFirebaseUser(firebaseUser);
    }catch(e){
        print(e.toString());
      }
      }

    Future signOut() async{
      try{
        return await _auth.signOut();
    }catch(e){
        print(e.toString());
        return null;
      }
      }

  }

