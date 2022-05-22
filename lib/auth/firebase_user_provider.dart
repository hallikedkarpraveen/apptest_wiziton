import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ApptestFirebaseUser {
  ApptestFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

ApptestFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ApptestFirebaseUser> apptestFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<ApptestFirebaseUser>(
        (user) => currentUser = ApptestFirebaseUser(user));
