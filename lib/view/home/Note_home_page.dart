import 'package:flutter/material.dart';
import 'package:flutter_firebase_note/controller/authController.dart';
import 'package:flutter_firebase_note/controller/noteController.dart';
import 'package:flutter_firebase_note/view/home/AddNote.dart';
import 'package:flutter_firebase_note/view/home/Drowar.dart';
import 'package:flutter_firebase_note/view/home/NoteDetails.dart';
import 'package:flutter_firebase_note/view/widgets/widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NoteHomePage extends StatefulWidget {
  const NoteHomePage({Key? key}) : super(key: key);

  @override
  _NoteHomePageState createState() => _NoteHomePageState();
}

class _NoteHomePageState extends State<NoteHomePage> {
  MaxLine(int index) {
    var sum = ((index % 4 + 1) * 1);

    switch (sum) {
      case 1:
        return sum + 2;
      case 2:
        return sum + 3;
      case 3:
        return sum + 4;
      case 4:
        return sum + 5;
      default:
        return sum + 2;
    }
  }

  final noteCtr = Get.find<Notecontroller>();

  @override
  void initState() {
    Future.delayed(Duration(microseconds: 0), () async {
      await noteCtr.NoteGet();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        drawer: Drowar(),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (noteCtr.scrollPosition.value < 100)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 70, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              text('Hey michel,', 24, FontWeight.w700,
                                  0xFFF000000),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(65)),
                                    child: Image.network(
                                      'https://cdn-icons-png.flaticon.com/128/3135/3135715.png',
                                      fit: BoxFit.cover,
                                    )),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: text(
                            'Good morning', 24, FontWeight.w700, 0xFFF000000),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 20,
                  ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                color: Color(0xFFFF5F6FB),
                width: 350,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Search '),
                ),
              ),
            ),
            (noteCtr.scrollPosition.value < 100)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: text('NOTE', 24, FontWeight.w700, 0xFFF000000),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 10,
                  ),
            Expanded(
              child: noteCtr.isLoading.isTrue
                  ? Center(child: CircularProgressIndicator())
                  : MasonryGridView.builder(
                      controller: noteCtr.scrolCtr,
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: noteCtr.notesdata.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            print('hello');
                            print(noteCtr.notesdata[index]['time'].toString());
                            noteCtr.SingleNorte.add(noteCtr.notesdata[index]);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => NoteDetails(),
                                ));
                          },
                          child: Container(
                            margin: index == 1
                                ? EdgeInsets.only(top: 30)
                                : EdgeInsets.only(top: 0),
                            child: custom_NOTE_Card(
                              ((index % 4 + 1) * 44 + 200),
                              MaxLine(index),
                              color: 0xFFFE8F5FB,
                              Description: noteCtr.notesdata[index]['note'],
                              Health: noteCtr.notesdata[index]['title'],
                              may: noteCtr.formatTimestamp(
                                  noteCtr.notesdata[index]['time']),
                            ),
                          ),
                        );
                      }),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.grid_view_rounded,
                        size: 35,
                      ))),
              FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 77, 190, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => AddNote()));
                },
                elevation: 10,
                child: Icon(
                  Icons.add_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Center(
                  child: Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.person_2_rounded,
                      size: 40,
                    )),
              ))
            ],
          ),
        ),
      );
    });
  }
}
