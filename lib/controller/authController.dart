import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authcontroller extends GetxController {
  GoogleAuth() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? account = await googleSignIn.signIn();
    print(account!.id);
    print(account.displayName);
    print(account.photoUrl);
    print(account.serverAuthCode);
    print(account.email);
    print(account.authHeaders);
    print(account.authentication);
    print(account.serverAuthCode);
  }
}
