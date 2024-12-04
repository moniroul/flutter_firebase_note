import 'package:flutter/material.dart';
import 'package:flutter_firebase_note/controller/noteController.dart';
import 'package:flutter_firebase_note/view/widgets/widget.dart';
import 'package:get/get.dart';

class AddNote extends StatelessWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteCtr = Get.find<Notecontroller>();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: noteCtr.titleCtr,
                  decoration: InputDecoration(hintText: "Title"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: noteCtr.noteCtr,
                  decoration: InputDecoration(
                    hintText: "write your note",
                    label: Icon(Icons.edit_document),
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  maxLines: 5,
                ),
                custom_ElevatedButton(() async {
                  if ((noteCtr.docID.value.length > 2)) {
                    await noteCtr.NoteUpdate(context);
                  } else {
                    await noteCtr.NoteDataSave(context);
                  }
                },
                    (noteCtr.docID.value.length > 2)
                        ? "Update Note"
                        : 'Add Note'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
