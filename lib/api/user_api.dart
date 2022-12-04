import 'package:chartapp/api/notifiers/user_notifier.dart';
import 'package:chartapp/components/models/msg_model.dart';
import 'package:chartapp/components/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

UserModel _currentUser = UserModel();

signInUser(UserModel user, AuthNotifier currentUser) async {
  AuthNotifier? authNotifier;
  UserCredential result = await FirebaseAuth.instance
      .signInWithEmailAndPassword(
          email: user.email!.trim(), password: user.password!.trim())
      .catchError(
        (error) => print(error.code),
      );

  print(_currentUser);

  User? firebaseUser = result.user;

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier?.setUser(firebaseUser);
  }
}

MessageModel messageM = MessageModel();

CollectionReference msgRef = FirebaseFirestore.instance.collection("messages");

FirebaseAuth _user = FirebaseAuth.instance;
registerUser(UserModel user, AuthNotifier authNotifier) async {
  UserCredential registerResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: user.email!.trim(), password: user.password!.trim())
      .catchError(
        // ignore: invalid_return_type_for_catch_error
        (error) => print(error.code),
      );
  user.id = registerResult.user!.uid;

  // ignore: await_only_futures, avoid_single_cascade_in_expression_statements

  User? firebaseUser = registerResult.user;
  // creates a doc with userUID
  msgRef.doc(registerResult.user!.uid).set(messageM.toMap());

  if (firebaseUser != null) {
    await firebaseUser.reload();
    User currentUser = FirebaseAuth.instance.currentUser!;
    authNotifier.setUser(currentUser);
  }
}

initializeCurrentUser(AuthNotifier? authNotifier) async {
  var appUser = FirebaseAuth.instance.currentUser;
  authNotifier!.setUser(appUser!);
}
