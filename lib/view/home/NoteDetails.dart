import 'package:flutter/material.dart';
import 'package:flutter_firebase_note/controller/noteController.dart';
import 'package:get/get.dart';

class NoteDetails extends StatefulWidget {
  NoteDetails({Key? key}) : super(key: key);

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  final Ctr = Get.find<Notecontroller>();

  @override
  void dispose() {
    Ctr.SingleNorte.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Details"),
      ),
      body: Center(
        child: Text(
            "Note : ${Ctr.SingleNorte.length > 0 ? Ctr.SingleNorte[0]['note'] : 'No Note !'}"),
      ),
    );
  }
}
