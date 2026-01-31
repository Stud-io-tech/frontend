import 'package:google_sign_in/google_sign_in.dart';

import 'auth_google_service.dart';

class AuthGoogleServiceImpl implements AuthGoogleService {
  final googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  @override
  Future<GoogleSignInAccount?> login() async {
    return await googleSignIn.signIn();
  }

  @override
  Future logout() async {
    await googleSignIn.signOut();
  }
}
