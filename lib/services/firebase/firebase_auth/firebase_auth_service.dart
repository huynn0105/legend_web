import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../app_data.dart';
import '../../../common/utils/log_util.dart';
import '../firebase_service.dart';

abstract class FirebaseAuthProtocol extends FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  StreamSubscription? _authSubscription;

  User? get currentUser;

  signInAnonymously();

  signInWithCustomToken(String token);

  onAuthStateChanges(User? user);

  signOut();

  @override
  dispose() {
    _authSubscription?.cancel();
  }
}

class FirebaseAuthService extends FirebaseAuthProtocol {
  FirebaseAuthService._();

  static final FirebaseAuthService instance = FirebaseAuthService._();

  @override
  User? get currentUser => _auth.currentUser;

  @override
  onAuthStateChanges(User? user) async {
    final token = await user?.getIdToken();
    AppData.instance.firebaseAuthToken = token;
    AppLog.d('FirebaseAuthService', '$token');
  }

  @override
  signInAnonymously() async {
    final result = await _auth.signInAnonymously();
    if (result.user != null) {
      _authSubscription = _auth.authStateChanges().listen(onAuthStateChanges);
    }
  }

  @override
  signInWithCustomToken(String token) async {
    final result = await _auth.signInWithCustomToken(token);
    if (result.user != null) {
      _authSubscription = _auth.authStateChanges().listen(onAuthStateChanges);
    }
  }

  @override
  signOut() {
    _auth.signOut();
  }
}
