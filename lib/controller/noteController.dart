import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_note/DatabaseService/noteService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notecontroller extends GetxController {
  TextEditingController titleCtr = TextEditingController();
  TextEditingController noteCtr = TextEditingController();
  ScrollController scrolCtr = ScrollController();

  final scrollPosition = 0.0.obs;

  final SingleNorte = <QueryDocumentSnapshot>[].obs;

  NoteService noteService = NoteService();

  final notesdata = <QueryDocumentSnapshot>[].obs;
  final isLoading = false.obs;
  NoteGet() async {
    isLoading.value = true;
    SharedPreferences sp = await SharedPreferences.getInstance();
    String userId = await sp.getString('uid')!;
    var d = await noteService.noteGet(userId);
    notesdata.value = d;
    isLoading.value = false;
  }

  Future NoteDataSave(BuildContext ctx) async {
    if (titleCtr.text.length > 1) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      var data = {
        'userId': sp.getString('uid'),
        "title": titleCtr.text,
        "note": noteCtr.text,
        "time": FieldValue.serverTimestamp(),
      };
      await noteService.NoteDataSave(data);
      await NoteGet();
      titleCtr.clear();
      noteCtr.clear();
      Fluttertoast.showToast(msg: "NoteSaved");
      Navigator.pop(ctx);
    } else {
      Fluttertoast.showToast(msg: "Enter Title");
    }
  }

  String formatTimestamp(Timestamp timestamp) {
    // Convert Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();

    // Format the DateTime
    String formattedTime =
        DateFormat('hh:mm a').format(dateTime); // e.g., 10:20 PM
    String formattedDate = DateFormat('d MMM').format(dateTime); // e.g., 12 May

    // Combine time and date
    return '$formattedTime $formattedDate';
  }

  final docID = ''.obs;
  NoteUpdate(BuildContext ctx) async {
    if (docID.value.length > 2) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      var data = {
        'userId': sp.getString('uid'),
        "title": titleCtr.text,
        "note": noteCtr.text,
        "time": FieldValue.serverTimestamp(),
      };
      var res = await noteService.NoteUpdate(docID.value, data);
      if (res) {
        Fluttertoast.showToast(msg: "Note Updated");
        titleCtr.clear();
        noteCtr.clear();
        docID.value = '';
        await NoteGet();
        Navigator.pop(ctx);
      } else {
        Fluttertoast.showToast(msg: "Note Update Failed");
      }
    } else {
      Fluttertoast.showToast(msg: "Select Note");
    }
  }

  NoteDelete(String id) async {
    await noteService.NoteDelete(id);
    await NoteGet();
  }

  @override
  void onInit() {
    scrolCtr.addListener(() {
      scrollPosition.value = scrolCtr.position.pixels;
      print(scrollPosition.value);
    });
    super.onInit();
  }
}
