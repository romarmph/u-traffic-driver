import 'package:u_traffic_driver/utils/exports/packages.dart' as auth;
import 'package:u_traffic_driver/utils/exports/packages.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';

class AuthService {
  const AuthService._();

  static const AuthService _instance = AuthService._();
  static AuthService get instance => _instance;

  static final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? get currentuser => _firebaseAuth.currentUser;

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges();
  }

  Future<Driver?> getDriver(String email) async {
    const String collection = "drivers";
    const String field = "email";

    final QuerySnapshot<Map<String, dynamic>> result =
        await _db.collection(collection).where(field, isEqualTo: email).get();

    if (result.docs.isEmpty) {
      return null;
    }

    Driver driver = Driver.fromJson(
      result.docs.first.data(),
      result.docs.first.id,
    );

    return driver;
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (await getDriver(email) == null) {
      throw Exception("driver-account-not-found");
    }

    final auth.UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final auth.UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    return userCredential.user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    try {
      final auth.User? user = _firebaseAuth.currentUser;

      final auth.AuthCredential credential = auth.EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPassword);
    } catch (e) {
      rethrow;
    }
  }
}
