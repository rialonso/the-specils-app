import 'dart:math';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_specials_app/shared/services/apis/consume_apis.dart';
import 'package:the_specials_app/shared/services/factory/sign_in_google.dart';

class AuthService {
  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn(clientId: "670097540184-l69jst81har5d985sj5j4l1800ukkm6s.apps.googleusercontent.com").signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    return GoogleSignInFactory(email: gUser.email, token: gAuth!.idToken as String);

  }
}
//com.googleusercontent.apps.670097540184-3liid93hjkcib38idqtrnvrgfa6drm69