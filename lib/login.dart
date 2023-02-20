import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<User?> login(String name) async{
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User? user = (await _auth.signInWithEmailAndPassword(
        email: name, password: "123456")).user;

    if(user!=null)
    {
      print("Login Successful");
      user.updateProfile(displayName: name);
    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      'name':name,'uid': _auth.currentUser!.uid}
    );
      return user;
    }
    else
      {
        return user;
      }
    return null;
  }
  catch (e){
    print(e);
  }
}