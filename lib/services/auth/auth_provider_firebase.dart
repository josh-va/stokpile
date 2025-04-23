import 'package:firebase_auth/firebase_auth.dart'
    show EmailAuthProvider, FirebaseAuth, FirebaseAuthException, UserCredential;
import 'package:firebase_core/firebase_core.dart';
import 'package:stokpile/exceptions/auth_exceptions.dart';
import 'package:stokpile/firebase_options.dart';
import 'package:stokpile/services/auth/auth_provider.dart';
import 'package:stokpile/services/auth/auth_user.dart';

class FirebaseAuthProvider implements BaseAuthProvider {
  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser> convertAnonUser({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await linkUserWithEmail(
        email,
        password,
      );

      return userWithCredentials(userCredential);
    } on FirebaseAuthException catch (e) {
      throwAuthExceptionE(
        email: email,
        exception: e,
        password: password,
      );
    } catch (e) {
      throw const GenericException();
    }
  }

  @override
  Future<AuthUser> createEmailUser({
    required String email,
    required String password,
  }) async {
    try {
      return await createUserWithEmailAndPassword(
        email,
        password,
      );
    } on FirebaseAuthException catch (e) {
      throwAuthExceptionE(
        email: email,
        password: password,
        exception: e,
      );
    } catch (_) {
      throw const GenericException();
    }
  }

  Future<AuthUser> createUserWithEmailAndPassword(
      String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userIfLoggedIn();
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<UserCredential> linkUserWithEmail(
      String email, String password) async {
    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    final userCredential =
        await FirebaseAuth.instance.currentUser!.linkWithCredential(credential);

    return userCredential;
  }

  @override
  Future<AuthUser> logInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      return userIfLoggedIn();
    } catch (_) {
      throw const GenericException();
    }
  }

  @override
  Future<AuthUser> logInEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await logInUserWithEmailAndPassword(
        email,
        password,
      );
    } on FirebaseAuthException catch (e) {
      throwAuthExceptionE(
        email: email,
        exception: e,
        password: password,
      );
    } catch (_) {
      throw const GenericException();
    }
  }

  Future<AuthUser> logInUserWithEmailAndPassword(
      String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userIfLoggedIn();
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw const UserNotLoggedInException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw const UserNotLoggedInException();
    }
  }

  @override
  Future<void> sendPasswordReset(toEmail) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      throwPasswordResetExceptionE(e);
    } catch (_) {
      throw const GenericException();
    }
  }

  Never throwAuthExceptionE({
    required String email,
    required FirebaseAuthException exception,
    required String password,
  }) {
    if (email == '') {
      throw const EmptyEmailException();
    } else if (exception.code == 'invalid-email') {
      throw const InvalidEmailException();
    } else if (password == '') {
      throw const EmptyPasswordException();
    } else if (exception.code == 'weak-password') {
      throw const WeakPasswordException();
    } else if (exception.code == 'email-already-in-use') {
      throw const EmailAlreadyInUseException();
    } else {
      throw const GenericAuthException();
    }
  }

  Never throwPasswordResetExceptionE(FirebaseAuthException e) {
    switch (e.code) {
      case 'firebase_auth/invalid-email':
        throw const InvalidEmailException();
      case 'firebase_auth/user-not-found':
        throw const UserNotFoundAuthException();
      default:
        throw const GenericAuthException();
    }
  }

  AuthUser userIfLoggedIn() {
    if (currentUser != null) {
      return currentUser!;
    } else {
      throw const UserNotLoggedInException();
    }
  }

  AuthUser userWithCredentials(UserCredential userCredential) {
    final user = AuthUser.fromFirebase(userCredential.user!);

    return user;
  }
}
