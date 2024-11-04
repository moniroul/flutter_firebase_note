import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_note/DatabaseService/authService.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authcontroller extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final aggrement = false.obs;
  final address = "".obs;
  final profile = "".obs;

  AuthService authService = AuthService();

  UserSignup() async {
    if (email.text.length > 3 &&
        password.text.length > 7 &&
        aggrement.value == true) {
      UserCredential res = await authService.Signup(email.text, password.text);
      print(res.user!.uid);
      var data = {
        "id": res.user!.uid,
        "name": name.text,
        "email": email.text,
        "profile": profile.value,
        "aggrement": aggrement.value == true ? true : false,
        "address": address.value,
      };
      authService.AuthDataSave(data);
    } else {
      print("Provide valid data ");
    }
  }

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
