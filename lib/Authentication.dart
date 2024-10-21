import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Authentication{
  final GoogleSignIn _googleSignIn=GoogleSignIn();
  final FirebaseAuth _auth=FirebaseAuth.instance;

  Future<void> logout() async{
    await _googleSignIn.disconnect();
    _auth.signOut();
  }
  Future<UserCredential?> loginGoogle() async{
    try{
      final googleUser=await _googleSignIn.signIn();
      final userAuth=await googleUser?.authentication;
      final cred=GoogleAuthProvider.credential(
        idToken: userAuth?.idToken,
        accessToken: userAuth?.accessToken,
      );
      if (kDebugMode) {
        print(googleUser?.toString());
      }

      return await _auth.signInWithCredential(cred);
    }
    catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
}