import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signInWithFirebase(email, password) async {
    // Attempt to get the currently authenticated user
    FirebaseUser user = await _auth.currentUser();
    if (user == null) {
      // Attempt to sign in without user interaction
      try {
        user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } catch (e) {
        throw new Exception(e);
      }
    }

    try {
      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
    } catch (e) {
      throw new Exception(e);
    }
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var currentUser = await prefs.setString('currentUser', email.substring(0, email.length-('@gmail.com'.length)));
    return user;
  }

  Future<Null> signOutWithGoogle() async {
    // Sign out with firebase
    await _auth.signOut();
  }

//Future<FirebaseUser> handleSignUp(email, password) async {
//
//  final FirebaseUser user = await auth.createUserWithEmailAndPassword(email: email, password: password);
//
//  assert (user != null);
//  assert (await user.getIdToken() != null);
//
//  return user;
//
//}

}
