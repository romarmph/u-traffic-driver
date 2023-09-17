import 'package:u_traffic_driver/utils/exports/packages.dart' as auth;
import 'package:u_traffic_driver/utils/exports/packages.dart';
import 'package:u_traffic_driver/utils/exports/models.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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

  Future<User?>   createUserWithEmailAndPassword({
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
}
