import 'package:google_sign_in/google_sign_in.dart';

abstract interface class AuthGoogleService {
  Future<GoogleSignInAccount?> login();
  Future logout();
}
