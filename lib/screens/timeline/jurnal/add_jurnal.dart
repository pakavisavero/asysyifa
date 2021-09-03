import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddJurnal extends StatefulWidget {
  static String routeName = "/add_jurnal";

  @override
  _AddJurnalState createState() => _AddJurnalState();
}

class _AddJurnalState extends State<AddJurnal> {
  QuillController _controller = QuillController.basic();

  String title;
  String desc;

  void add() {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('notes');

    var data = {
      'title': title,
      'description': jsonEncode(_controller.document.toDelta().toJson()),
      'crated': DateTime.now(),
    };

    print(data);

    ref.add(data);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Color(0xff1948AE),
          title: Text(
            'Tambahkan Jurnal Harian',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(height: 12.0),
                Form(
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Masukkan Judul',
                        ),
                        onChanged: (_val) {
                          title = _val;
                        },
                      ),
                      SizedBox(height: 25),
                      QuillToolbar.basic(controller: _controller),
                      SizedBox(height: 25),
                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                        ),
                        child: QuillEditor.basic(
                          controller: _controller,
                          readOnly: false, // true for view only mode
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: add,
          backgroundColor: Colors.red,
          child: FaIcon(FontAwesomeIcons.save),
        ),
      ),
    );
  }
}
