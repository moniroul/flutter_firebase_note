import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_note/DatabaseService/authService.dart';
import 'package:flutter_firebase_note/view/home/Home_v2.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  UserSignup(BuildContext ctx) async {
    try {
      if (email.text.length > 3 &&
          password.text.length > 7 &&
          aggrement.value == true) {
        UserCredential res =
            await authService.Signup(email.text, password.text);
        print(res.user!.uid);
        var data = {
          "id": res.user!.uid,
          "name": name.text,
          "email": email.text,
          "profile": profile.value,
          "aggrement": aggrement.value == true ? true : false,
          "address": address.value,
        };
        authService.AuthDataSave(data, ctx);
      } else {
        print("Provide valid data ");
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg:
              "${e.toString().replaceAll("[firebase_auth/email-already-in-use]", "")}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future UserSignin(BuildContext ctx) async {
    try {
      var res = await authService.Signin(email.text, password.text); 
      if (!res.user!.uid.isEmpty) {
        Navigator.push(ctx, MaterialPageRoute(builder: (_) => HomePage()));
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg:
              "${e.toString().replaceAll("[firebase_auth/invalid-credential]", "")}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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
